-- initialize
vim.loader.enable()

WK = require('which-key')
WK.setup {
  theme = 'helix',
  win = { border = 'single' },
}
WK.add { ' ', '<Nop>', { silent = true, remap = false } }

vim.g.mapleader = ' '

-- colors & ui
vim.opt.termguicolors = true
vim.opt.winborder = 'single'

vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = false
vim.g.moonflyUndercurls = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme('moonfly')

vim.opt.smoothscroll = true

vim.opt.expandtab = true -- spaces as tab
vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.shiftwidth = 0 -- Reuse value of tabstop

vim.opt.fillchars = {
  eob = ' ',
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- globals
KeyMaps = function(keys, opts)
  return vim.tbl_map(function(key)
    if type(key[#key]) == 'table' then
      key[#key] = vim.tbl_deep_extend('keep', key[#key], opts)
    end
    return key
  end, keys)
end

-- sync imports
require('config.options')
require('config.keymaps')
require('config.autocmds')
-- require("config.plugins")
