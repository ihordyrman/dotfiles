return {
  {
    "ionide/Ionide-vim",
    ft = { "fsharp" },
    init = function()
      vim.g["fsharp#fsi_command"] = "dotnet fsi"
      vim.g["fsharp#fsi_keymap"] = "none"
      vim.g["fsharp#show_signature_on_cursor_move"] = 1
    end,
    config = function()
      vim.keymap.set("n", "<leader>fs", ":FsiSendLine<CR>", { desc = "[F]# [S]end line to FSI" })
      vim.keymap.set("v", "<leader>fs", ":FsiSendSelection<CR>", { desc = "[F]# [S]end selection to FSI" })
      vim.keymap.set("n", "<leader>ff", ":FsiSendFile<CR>", { desc = "[F]# Send [F]ile to FSI" })
      vim.keymap.set("n", "<leader>fr", ":FsiReset<CR>", { desc = "[F]# [R]eset FSI" })
      vim.keymap.set("n", "<leader>ft", ":FsiTogglePane<CR>", { desc = "[F]# [T]oggle FSI pane" })
    end,
  },
}
