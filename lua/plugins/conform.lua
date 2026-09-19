return {
  "conform.nvim",
  cmd = "ConformInfo",
  event = "BufWritePre",
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      desc = "Format buffer",
      mode = "",
    },
  },
  after = function()
    require("conform").setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt", "alejandra", stop_after_first = true },
        rust = { "rustfmt" },
        python = { "ruff_format", "ruff_organize_imports" },
        zig = { "zigfmt" },
        ["_"] = { "trim_whitespace" },
      },
    }
  end,
}
