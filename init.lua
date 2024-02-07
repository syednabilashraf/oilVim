require("config.lazy")
vim.cmd([[set clipboard=unnamedplus]])

-- Map dd to "_dd in normal mode
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "E", "$", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "B", "0", { noremap = true, silent = true })
