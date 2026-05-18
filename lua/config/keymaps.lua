-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<C-p>", LazyVim.pick("files", { root = false, hidden = true }))
map("n", "<C-z>", LazyVim.pick("live_grep", { root = false, hidden = true }))
-- map("n", "<S-b>", "<cmd> Telescope git_bcommits <CR>")

map("n", "<C-q>", function()
  Snacks.bufdelete()
end)

map("n", "<C-j>", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
map("n", "<C-k>", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

map("n", "<C-n>", function()
  Snacks.explorer()
end)

map("n", "<Leader>z", "1z=")

map("n", "0", "^")
map("n", "^", "0")

map("i", "<C-a>", "<ESC>I")
map("i", "<C-e>", "<ESC>A")
map("i", "<C-h>", "<C-o>B")
map("i", "<C-l>", "<C-o>W")
