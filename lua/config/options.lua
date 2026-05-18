-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.list = true
vim.opt.wrap = true

vim.opt.listchars:append("tab:·▸")
vim.opt.listchars:append("trail:·")
vim.opt.listchars:append("space:·")
vim.opt.listchars:append("multispace:·")
vim.opt.listchars:append("nbsp:⎵")

vim.g.loaded_python3_provider = 0
vim.g.autoformat = true
