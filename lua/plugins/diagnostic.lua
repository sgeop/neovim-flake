return {
  'tiny-inline-diagnostic.nvim',
  lazy = false,
  after = function()
    vim.diagnostic.config {
      update_in_insert = false,
      virtual_text = false,
      virtual_lines = { enable = false, current_line = false },
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

    require('tiny-inline-diagnostic').setup {
      preset = 'modern',
      options = {
        multilines = {
          enabled = false,

          show_all_diags_on_cursorline = true,
        },
      },
    }
  end,
}
