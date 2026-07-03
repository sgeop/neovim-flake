return {
  'tiny-inline-diagnostic.nvim',
  lazy = false,
  after = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'modern',
      options = {
        multilines = {
          enabled = true,
        },
      },
    }
  end,
}
