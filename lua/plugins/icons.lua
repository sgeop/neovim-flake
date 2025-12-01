return {
	{
		"nvim-web-devicons",
		event = "DeferredUIEnter",
		after = function()
			require("nvim-web-devicons")
		end,
	},
	{
		"mini.icons",
		event = "DeferredUIEnter",
		before = function()
			LZN.trigger_load("nvim-web-devicons")
		end,
		after = function()
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
