return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "light"

    require("everforest").setup({
      -- background = "soft",
      -- ui_contrast = "low",
      -- dim_inactive_windows = true,
      -- diagnostic_virtual_text = "coloured",
      -- inlay_hints_background = "dimmed",
      float_style = "bright",
    })

    vim.cmd([[colorscheme everforest]])
  end,
}
