local python = vim.fn.exepath('python3') or vim.fn.exepath('python') or '.venv/bin/python'

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'requirements.txt', 'pyrightconfig.json', '.git' },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
    python = {
      pythonPath = python,
    },
  },
}
