lspconfig = require "lspconfig"

local zls = vim.fn.exepath "zls"
local zig = vim.fn.exepath "zig"

---@type vim.lsp.Config
return {
  cmd = { zls },
  filetypes = { "zig", "zir" },
  root_markers = { { "build.zig", "zls.json" }, ".git" },
  workspace_required = false,
  ---@type lspconfig.settings.zls
  settings = {
    zls = {
      enable_ast_check_diagnostics = true,
      enable_build_on_save = true,
      enable_inlay_hints = true,
      enable_snippets = true,
      inlay_hints_hide_redundant_param_names = true,
      enable_semantic_tokens = true,
      zig_exe_path = zig,
    },
    -- zls = {
    --   semantic_tokens = "partial",
    --   enable_build_on_save = true,
    --   -- zig_exe_path = zig,
    -- },
  },
}
