local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- easier window navigation
map('n', '<C-h>', '<C-W>h', { desc = 'Go to Window left', remap = true })
map('n', '<C-j>', '<C-W>j', { desc = 'Go to Window below', remap = true })
map('n', '<C-k>', '<C-W>k', { desc = 'Go to Window above', remap = true })
map('n', '<C-l>', '<C-W>l', { desc = 'Go to Window right', remap = true })

-- quick switch to last edited file
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Swtich to last buffer' })

-- Create new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- Quit operations
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })
