local opt = vim.opt

opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.jumpoptions = 'stack,view'
opt.autoindent = true

opt.hlsearch = false

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

opt.grepprg = 'rg --vimgrep'

-- execute .nvim.lua files in project root
vim.opt.exrc = true
