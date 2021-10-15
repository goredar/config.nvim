local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cmdheight = 1
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.conceallevel = 2
vim.opt.virtualedit = "block"
-- vim.opt.mouse = 'a'
vim.opt.mousefocus = true
vim.opt.ruler = true
vim.opt.inccommand = "split"
vim.opt.foldenable = false
vim.opt.foldmethod = "marker"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.laststatus = 2

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false

-- Pumemu
vim.opt.pumblend = 10
vim.opt.winblend = 10

-- Update times
vim.opt.updatetime = 300
