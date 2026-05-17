return {
  'nvim-lspconfig',
  event = 'DeferredUIEnter',
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

    vim.lsp.enable {
      'nixd',
      'lua_ls',
      'bashls',
      'basedpyright',
      'zls',
      'rust_analyzer',
      'gopls',
      'vtsls',
      'marksman',
    }

    -- vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Actions' })
    -- vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
    -- vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover Documentation' })
    -- vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Signature Help' })
    -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover (alt)' })
    -- vim.keymap.set('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Goto Definition' })
    -- vim.keymap.set('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Goto Declaration' })
    -- vim.keymap.set('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Goto Definition' })
    -- vim.keymap.set('n', '<leader>lgn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { desc = 'Next Diagnostic' })
    -- vim.keymap.set('n', '<leader>lgp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { desc = 'Prev Diagnostic' })
    -- vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover Documentation' })
  end,
  wk = {
    { '<leader>g', 'LSP' },
    { '<leader>lg', 'Decs/Defs' },
  },
}
