return {
  "conform.nvim",
  cmd = "ConformInfo",
  event = "BufWritePre",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format buffer",
      mode = "",
    },
  },
  after = function()
    require("conform").setup({
      format_on_save = function()
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
      },
    })
  end,
}
