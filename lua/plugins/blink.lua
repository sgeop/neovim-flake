local source_icons = {
  minuet = '󱗻',
  orgmode = '',
  otter = '󰼁',
  nvim_lsp = '',
  lsp = '',
  buffer = '',
  luasnip = '',
  snippets = '',
  path = '',
  git = '',
  tags = '',
  cmdline = '󰘳',
  latex_symbols = '',
  cmp_nvim_r = '󰟔',
  codeium = '󰩂',
  -- FALLBACK
  fallback = '󰜚',
}

return {
  { 'lspkind.nvim' },
  { 'blink-ripgrep.nvim' },
  {
    'blink.cmp',
    lazy = false,
    -- event = 'DeferredUIEnter',
    before = function()
      LZN.trigger_load('lazydev.nvim')
      -- LZN.trigger_load('lspkind.nvim')
      -- LZN.trigger_load('mini.icons')
      LZN.trigger_load('blink-ripgrep.nvim')
    end,
    after = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'TERM',
            name = 'Llama.cpp',
            end_point = 'https://llama.tail51da8.ts.net/upstream/qwen2-coder-7b/v1/completions',
            -- The model is set by the llama-cpp server and cannot be altered
            -- post-launch.
            model = 'PLACEHOLDER',
            optional = {
              max_tokens = 120,
              top_p = 0.9,
            },
            -- Llama.cpp does not support the `suffix` option in FIM completion.
            -- Therefore, we must disable it and manually populate the special
            -- tokens required for FIM completion.
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                return '<|fim_prefix|>'
                  .. context_before_cursor
                  .. '<|fim_suffix|>'
                  .. context_after_cursor
                  .. '<|fim_middle|>'
              end,
              suffix = false,
            },
          },
        },
      }

      --@module "blink.cmp"
      --@type blink.cmp.Config
      require('blink.cmp').setup {
        appearance = {},
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
                { 'source_icon' },
              },
              treesitter = { 'lsp' },
              components = {
                source_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    return source_icons[ctx.source_name:lower()] or source_icons.fallback
                  end,
                  highlight = 'BlinkCmpSource',
                },
              },
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
          ['<C-y>'] = require('minuet').make_blink_map(),

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
            minuet = {
              name = 'minuet',
              module = 'minuet.blink',
              async = true,
              timeout_ms = 3000,
              score_offset = 50,
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
