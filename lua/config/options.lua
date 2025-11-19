vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.jumpoptions = "stack,view"
vim.o.autoindent = true

vim.o.hlsearch = false

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

-- UI

vim.o.winborder = "rounded"
vim.o.termguicolors = true

vim.o.smoothscroll = true

vim.o.expandtab = true -- spaces as tab
vim.o.tabstop = 2 -- 2 spaces for tabs
vim.o.shiftwidth = 0 -- Reuse value of tabstop

-- execute .nvim.lua files in project root
vim.opt.exrc = true
