return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "light"

    require("everforest").setup({
      italics = false,
      disable_italic_comments = true,
      background = "medium",
      transparent_background_level = 0,
      ui_contrast = "low",
      dim_inactive_windows = false,
      diagnostic_virtual_text = "coloured",
      float_style = "bright",
    })

    vim.cmd([[colorscheme everforest]])
  end,
}
