return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && npm install",
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<CR>",
        ft = "markdown",
        desc = "[M]arkdown [P]review",
      },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "vault",
          path = "~/OneDrive/Documents/Obsidian",
        },
      },

      ui = {
        enable = true,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },

      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },

      mappings = {
        ["gf"] = {
          action = function() return require("obsidian").util.gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function() return require("obsidian").util.toggle_checkbox() end,
          opts = { buffer = true, desc = "Toggle [C]heck[b]ox" },
        },
        ["<cr>"] = {
          action = function() return require("obsidian").util.smart_action() end,
          opts = { buffer = true, expr = true },
        },
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function() vim.o.conceallevel = 2 end,
      })
    end,
  },
}
