local function get_python()
  if vim.loop.fs_stat('.venv/bin/python') ~= nil then
    return { pythonPath = vim.loop.cwd() .. '/.venv/bin/python' }
  end
  local path = vim.fn.exepath('python') or vim.fn.exepath('python3')
  if path ~= nil then
    return { pythonPath = path }
  else
    return {}
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'requirements.txt', 'pyrightconfig.json', '.git' },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        autoImportCompletions = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        reportMissingTypeStubs = 'off',
        typeCheckingMode = 'standard',
      },
    },
    python = get_python(),
  },
}
