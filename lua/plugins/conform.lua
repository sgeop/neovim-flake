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
        go = { 'gofumpt' },
        lua = { 'stylua' },
        nix = { 'alejandra', 'nixfmt' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        rust = { 'rustfmt' },
        sh = { 'shellcheck' },
        yaml = { 'yq', 'yamlfmt' },
        json = { 'jq' },
        zig = { 'zigfmt' },
        ['_'] = { 'trim_whitespace' },
      },
    }
  end,
}
