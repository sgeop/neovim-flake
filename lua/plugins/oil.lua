return {
  "oil.nvim",
  event = "DeferredUIEnter",
  enabled = false,
  after = function()
    require("oil").setup({
      keymaps = {
        ["<leader>e"] = "actions.close",
      },
    })

    vim.keymap.set("n", "<leader>e", "<CMD>Oid<CR>")
  end,
  keys = {
    { "<leader>e", { "<CMD>Oil<CR>", mode = "n" } },
  },
}
