---@type vim.lsp.Config
return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
  settings = {
    bashls = {
      disgnostics = {
        enable = true,
      },
    },
  },
}
