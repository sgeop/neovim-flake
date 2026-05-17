return {
  'render-markdown.nvim',
  ft = { 'markdown', 'html', 'yaml', 'latex' },
  after = function()
    require('render-markdown').setup {
      enabled = true,
      restart_highlighter = true,
      preset = 'none',
      completions = { blink = { enabled = true } },
      code = {
        enabled = true,
        language_icon = true,
        conceal_delimiters = true,
        language = true,
        width = 'full',
        right_pad = 1,
      },
      file_types = { 'markdown', 'html', 'yaml', 'latex' },
      heading = {
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      checkbox = {
        enabled = true,
      },
      pipe_table = {
        enabled = true,
        preset = 'round',
      },
    }
    Snacks.toggle({
      name = 'Render Markdown',
      get = require('render-markdown').get,
      set = require('render-markdown').set,
    }):map('<leader>um')
  end,
}
