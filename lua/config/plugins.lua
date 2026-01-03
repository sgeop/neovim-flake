WK = require('which-key')
WK.setup {
  win = {
    border = 'single',
  },
}
WK.add { ' ', '<Nop>', { silent = true, remap = false } }

-- colorscheme setup
require('kanagawa').setup {
  compile = false,
  undercurl = true,
  keywordStyle = { italic = true },
  theme = 'wave',
  background = {
    dark = 'wave',
    light = 'lotus',
  },
}

vim.cmd('colorscheme kanagawa')
