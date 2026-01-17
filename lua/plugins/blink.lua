return {
  { 'lspkind.nvim' },
  { 'blink-ripgrep.nvim' },
  {
    'blink.cmp',
    event = 'DeferredUIEnter',
    before = function()
      LZN.trigger_load('lazydev.nvim')
      LZN.trigger_load('lspkind.nvim')
      LZN.trigger_load('mini.icons')
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
              preselect = true,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                      local mini_icon, _ = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_icon .. ctx.icon_gap
                      end
                    end

                    local icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
                    return icon .. ctx.icon_gap
                  end,

                  -- Optionally, use the highlight groups from mini.icons
                  -- You can also add the same function for `kind.highlight` if you want to
                  -- keep the highlight groups in sync with the icons.
                  highlight = function(ctx)
                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                      local mini_icon, mini_hl = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_hl
                      end
                    end
                    return ctx.kind_hl
                  end,
                },
                kind = {
                  -- Optional, use highlights from mini.icons
                  highlight = function(ctx)
                    if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                      local mini_icon, mini_hl = require('mini.icons').get_icon(ctx.item.data.type, ctx.label)
                      if mini_icon then
                        return mini_hl
                      end
                    end
                    return ctx.kind_hl
                  end,
                },
              },
              treesitter = { 'lsp' },
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

          ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
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
