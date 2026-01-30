return {
  { 'lspkind.nvim' },
  { 'blink-ripgrep.nvim' },
  {
    'blink.cmp',
    event = 'DeferredUIEnter',
    before = function()
      LZN.trigger_load('lazydev.nvim')
      -- LZN.trigger_load('lspkind.nvim')
      -- LZN.trigger_load('mini.icons')
      LZN.trigger_load('blink-ripgrep.nvim')
    end,
    after = function()
      --@module "blink.cmp"
      --@type blink.cmp.Config
      require('blink.cmp').setup {
        signature = { enabled = true },
        completion = {
          accept = { auto_brackets = { enabled = true } },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
            draw = {
              columns = {
                { 'label', 'label_description', gap = 1 },
                { 'kind_icon', 'kind', gap = 1 },
                { 'source_name' },
              },
              treesitter = { 'lsp' },
              -- components = {
              --   kind_icon = {
              --     text = function(ctx)
              --       local mini_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              --       return mini_icon
              --     end,
              --     highlight = function(ctx)
              --       local _, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --       return mini_hl
              --     end,
              --   },
              --   kind = {
              --     highlight = function(ctx)
              --       local _, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --       return mini_hl
              --     end,
              --   },
              -- },
            },
          },
          ghost_text = {
            enabled = true,
            show_with_menu = false,
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
        keymap = {
          preset = 'none',
          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },

          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },

          ['<Up>'] = { 'snippet_forward', 'fallback' },
          ['<Down>'] = { 'snippet_backward', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<C-n>'] = { 'select_next', 'fallback' },

          ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        },
        sources = {
          default = { 'lsp', 'buffer', 'snippets', 'path', 'ripgrep' },
          per_filetype = {
            lua = { inherit_defaults = true, 'lazydev' },
          },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
            lsp = {
              min_keyword_length = 2,
            },
            path = {
              min_keyword_length = 0,
            },
            ripgrep = {
              module = 'blink-ripgrep',
              name = 'Ripgrep',
              opts = {
                backend = {
                  use = 'gitgrep',
                },
              },
            },
            snippets = {
              min_keyword_length = 2,
            },
            buffer = {
              min_keyword_length = 4,
            },
          },
        },
      }
    end,
  },
}
