local zls = vim.fn.exepath('zls')
local zig = vim.fn.exepath('zig')

---@type vim.lsp.Config
return {
  cmd = { zls },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
  settings = {
    zls = {
      zig_exe_path = zig,
    },
  },
}
