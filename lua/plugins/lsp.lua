return {
  'nvim-lspconfig',
  before = function()
    LZN.trigger_load('blink.cmp')
  end,
  after = function()
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities({}, true),
    })

    vim.diagnostic.config {
      update_in_insert = false,
      virtual_text = false,
      virtual_lines = { enable = true, current_line = true },
      underline = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
          [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
      },
    }

    vim.lsp.enable { 'nixd', 'lua_ls', 'bashls', 'basedpyright', 'zls', 'rust_analyzer', 'gopls', 'vtsls' }

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Actions' })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Code Rename' })
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover (alt)' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
  end,
  wk = {
    { '<leader>c', 'Code' },
  },
}
