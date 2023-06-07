-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.tmux_navigator_no_mappings = 1

vim.api.nvim_set_keymap("n", "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":<C-U>TmuxNavigateDown<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":<C-U>TmuxNavigateUp<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":<C-U>TmuxNavigateRight<CR>", { silent = true })
