vim.loader.enable()

-- globals
vim.g.mapleader = " "

KeyMaps = function(keys, opts)
	return vim.tbl_map(function(key)
		if type(key[#key]) == "table" then
			key[#key] = vim.tbl_deep_extend("keep", key[#key], opts)
		end
		return key
	end, keys)
end

require("config.options")
require("config.keymaps")
require("config.plugins")
-- require("config.autocmds")
