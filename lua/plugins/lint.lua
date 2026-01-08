return {
  'nvim-lint',
  event = 'DeferredUIEnter',
  after = function()
    require('lint').linters_by_ft = {
      go = { 'golangcilint' },
      lua = { 'luacheck' },
      nix = { 'statix', 'deadnix' },
      rust = { 'clippy' },
      sh = { 'shellcheck' },
      terraform = { 'tflint', 'trivy' },
      json = { 'jsonlint' },
      yaml = { 'yamllint' },
      python = { 'ruff' },
      zig = { 'zigfmt' },
    }
  end,
}
