local M = {}

local fsproj_data = {} -- fsproj_path -> list of normalized relative paths
local order_cache = {} -- dir_path -> rank map or false

local function parse_fsproj(fsproj_path)
  if fsproj_data[fsproj_path] ~= nil then return fsproj_data[fsproj_path] end
  local f = io.open(fsproj_path, "r")
  if not f then
    fsproj_data[fsproj_path] = false
    return false
  end
  local content = f:read("*a")
  f:close()
  local paths = {}
  for path in content:gmatch('<Compile%s+Include="([^"]+)"') do
    table.insert(paths, (path:gsub("\\", "/")))
  end
  fsproj_data[fsproj_path] = paths
  return paths
end

local function find_fsproj_upward(dir)
  local current = dir
  while true do
    local handle = vim.loop.fs_opendir(current)
    if handle then
      while true do
        local entries = vim.loop.fs_readdir(handle)
        if not entries then break end
        for _, e in ipairs(entries) do
          if e.name:match("%.fsproj$") then
            vim.loop.fs_closedir(handle)
            return current, current .. "/" .. e.name
          end
        end
      end
      vim.loop.fs_closedir(handle)
    end
    local parent = vim.fn.fnamemodify(current, ":h")
    if parent == current then break end
    current = parent
  end
  return nil, nil
end

local function get_order(dir)
  if order_cache[dir] ~= nil then return order_cache[dir] end
  local fsproj_dir, fsproj_path = find_fsproj_upward(dir)
  if not fsproj_path then
    order_cache[dir] = false
    return false
  end
  local paths = parse_fsproj(fsproj_path)
  if not paths or #paths == 0 then
    order_cache[dir] = false
    return false
  end
  local prefix = ""
  if dir ~= fsproj_dir then prefix = dir:sub(#fsproj_dir + 2) .. "/" end
  local order = {}
  for i, path in ipairs(paths) do
    if prefix == "" then
      local first = path:match("^([^/]+)")
      if first and not order[first] then order[first] = i end
    else
      if path:sub(1, #prefix) == prefix then
        local first = path:sub(#prefix + 1):match("^([^/]+)")
        if first and not order[first] then order[first] = i end
      end
    end
  end
  order_cache[dir] = order
  return order
end

local function default_compare(a, b)
  if a.type ~= b.type then return a.type == "directory" end
  return a.name:lower() < b.name:lower()
end

function M.sorter(nodes)
  if #nodes == 0 then return end
  local dir = vim.fn.fnamemodify(nodes[1].absolute_path, ":h")
  local order = get_order(dir)
  if not order then
    table.sort(nodes, default_compare)
    return
  end
  table.sort(nodes, function(a, b)
    local ra = order[a.name]
    local rb = order[b.name]
    if ra == nil and rb == nil then
      return default_compare(a, b)
    elseif ra == nil then
      return true
    elseif rb == nil then
      return false
    else
      return ra < rb
    end
  end)
end

function M.invalidate(dir)
  for k in pairs(order_cache) do
    if k == dir or k:sub(1, #dir + 1) == dir .. "/" then order_cache[k] = nil end
  end
  for k in pairs(fsproj_data) do
    if k:sub(1, #dir + 1) == dir .. "/" or vim.fn.fnamemodify(k, ":h") == dir then
      fsproj_data[k] = nil
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.fsproj",
    callback = function(event)
      local dir = vim.fn.fnamemodify(event.file, ":h")
      M.invalidate(dir)
      local ok, api = pcall(require, "nvim-tree.api")
      if ok then api.tree.reload() end
    end,
  })
end

return M
