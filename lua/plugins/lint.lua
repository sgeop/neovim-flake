return {
  'nvim-lint',
  event = 'DeferredUIEnter',
  after = function()
    require('lint').linters_by_ft = {
      nix = { 'statix', 'deadnix' },
      lua = { 'luacheck' },
    }
  end,
}
