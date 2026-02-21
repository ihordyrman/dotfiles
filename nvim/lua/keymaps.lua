-- [[ Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-Up>", "<Up>ddp<Up>", { desc = "Move line up" })
vim.keymap.set("n", "<C-Down>", "ddp", { desc = "Move line down" })

-- Clear search highlighting
vim.cmd("noh") -- or vim.cmd.noh()

vim.api.nvim_create_user_command("FormatJSON", ":%!jq .", {})
