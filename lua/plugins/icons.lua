return {
  -- {
  --   "nvim-web-devicons",
  --   event = "DeferredUIEnter",
  --   after = function()
  --     require("nvim-web-devicons")
  --   end,
  -- },
  {
    'mini.icons',
    lazy = false,
    -- before = function()
    --   LZN.trigger_load("nvim-web-devicons")
    -- end,
    after = function()
      require('mini.icons').setup {
        use_file_extension = function(ext)
          return ext:sub(-3) ~= 'scm'
        end,
      }
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
