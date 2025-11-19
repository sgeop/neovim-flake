WK = require("which-key")
WK.setup({
	win = {
		border = "single",
	},
})
WK.add({ " ", "<Nop>", { silent = true, remap = false } })
