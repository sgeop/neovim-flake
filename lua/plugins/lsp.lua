return {
  'nvim-lspconfig',
  event = 'DeferredUIEnter',
  before = function()
    LZN.trigger_load('blink.cmp')
  end,
  after = function()
    local base_caps = vim.lsp.protocol.make_client_capabilities()

    local extra_caps = vim.tbl_deep_extend('force', base_caps, {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
    })

    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(extra_caps, true),
    })

    vim.lsp.enable {
      'nixd',
      'lua_ls',
      'bashls',
      'basedpyright',
      'zls',
      'rust_analyzer',
      'gopls',
      'tsgo',
      'marksman',
    }

    vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Actions' })
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
    vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover Documentation' })
    vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Signature Help' })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover (alt)' })
    vim.keymap.set('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Definition' })
    vim.keymap.set('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Declaration' })
    vim.keymap.set('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Type Definition' })
    vim.keymap.set('n', '<leader>lgn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { desc = 'Next Diagnostic' })
    vim.keymap.set('n', '<leader>lgp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { desc = 'Prev Diagnostic' })
    vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover Documentation' })
  end,
  wk = {
    { '<leader>l', 'LSP' },
    { '<leader>lg', 'Goto' },
  },
}
