local opt = vim.opt

opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.jumpoptions = "stack,view"
opt.autoindent = true

opt.hlsearch = false

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.grepprg = "rg --vimgrep"

-- UI

opt.winborder = "rounded"
opt.termguicolors = true

opt.smoothscroll = true

opt.expandtab = true -- spaces as tab
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 0 -- Reuse value of tabstop

opt.fillchars = { eob = " " }

-- execute .nvim.lua files in project root
vim.opt.exrc = true
