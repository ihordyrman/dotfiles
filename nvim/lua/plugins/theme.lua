return {
  "sainnhe/everforest",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "light"
    vim.g.everforest_background = "hard"
    vim.g.everforest_disable_italic_comment = 1
    vim.g.everforest_transparent_background = 0
    vim.g.everforest_ui_contrast = "low"
    vim.g.everforest_dim_inactive_windows = 0
    vim.g.everforest_diagnostic_virtual_text = "colored"
    vim.g.everforest_float_style = "bright"

    vim.cmd([[colorscheme everforest]])

    vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { link = "EndOfBuffer" })
  end,
}
