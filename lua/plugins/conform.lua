return {
  'conform.nvim',
  cmd = 'ConformInfo',
  event = 'BufWritePre',
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format buffer',
      mode = '',
    },
  },
  after = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'alejandra', 'nixfmt' },
        rust = { 'rustfmt' },
      },
    }
  end,
}
