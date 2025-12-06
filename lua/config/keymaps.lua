local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- easier window navigation
map("n", "<C-h>", "<C-W>h")
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-l>", "<C-W>l")
