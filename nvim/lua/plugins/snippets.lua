return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<C-l>", function() ls.jump(1) end,  { desc = "LuaSnip jump forward" })
      vim.keymap.set({ "i", "s" }, "<C-h>", function() ls.jump(-1) end, { desc = "LuaSnip jump backward" })
    end,
  },
}
