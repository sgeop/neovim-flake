local opt = vim.opt

opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.jumpoptions = 'stack,view'
opt.autoindent = true

-- line numbers and navigation
opt.number = true
opt.relativenumber = true
opt.cursorline = true -- highlight current line
opt.scrolloff = 10 -- keep 10 lines of space above/below cursor
opt.sidescrolloff = 8 -- same but left/right

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- performance settings
opt.synmaxcol = 300 -- limit syntax highlight to 300 columns
opt.updatetime = 400 -- faster completion
opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

opt.grepprg = 'rg --vimgrep'

-- execute .nvim.lua files in project root
vim.opt.exrc = true
