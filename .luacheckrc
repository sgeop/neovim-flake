-- Example .luacheckrc
return {
  -- Define global variables that luacheck should ignore, useful for Neovim config
  globals = {
    'vim',
    'use',
    'LZN',
    'Snacks',
  },
  -- Adjust the maximum line length
  max_line_length = 120,
  -- Suppress specific warnings by code
  -- Example: 211 (unused variable), 111 (accessing uninitialized variable)
  ignore = { '211', '111', '113' },
}
