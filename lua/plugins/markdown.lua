return {
  'render-markdown.nvim',
  ft = { 'markdown' },
  after = function()
    require('render-markdown').setup {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        signs = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    }
    Snacks.toggle({
      name = 'Render Markdown',
      get = require('render-markdown').get,
      set = require('render-markdown').set,
    }):map('<leader>um')
  end,
}
