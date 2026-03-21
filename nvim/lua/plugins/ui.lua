return {
  {
    "arcticicestudio/nord-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ", Down = "<Down> ", Left = "<Left> ", Right = "<Right> ",
          C = "<C-…> ", M = "<M-…> ", D = "<D-…> ", S = "<S-…> ",
          CR = "<CR> ", Esc = "<Esc> ", ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ", NL = "<NL> ", BS = "<BS> ",
          Space = "<Space> ", Tab = "<Tab> ",
          F1 = "<F1>", F2 = "<F2>", F3 = "<F3>", F4 = "<F4>",
          F5 = "<F5>", F6 = "<F6>", F7 = "<F7>", F8 = "<F8>",
          F9 = "<F9>", F10 = "<F10>", F11 = "<F11>", F12 = "<F12>",
        },
      },
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  { "HiPhish/rainbow-delimiters.nvim" },

  {
    "karb94/neoscroll.nvim",
    opts = {},
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {},
    config = function()
      require("smear_cursor").setup({})

      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          require("smear_cursor").enabled = false
        end,
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.buftype == "" then
            vim.fn.timer_start(70, function()
              require("smear_cursor").enabled = true
            end)
          end
        end,
      })
    end,
  },
}
