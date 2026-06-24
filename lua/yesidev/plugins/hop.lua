return {
	"smoka7/hop.nvim",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	config = function()
		-- import hop plugin
		local hop = require("hop")

		-- enable hop
		hop.setup()

		-- keybind options
		local opts = { noremap = true, silent = true }

		local function hopShortcut(mode)
			return vim.keymap.set(mode, "<leader>m", "<cmd>HopChar2<CR>", opts)
		end

		-- set keybinds
		for _, mode in ipairs({ "n", "v" }) do
			opts.desc = "Hop"
			hopShortcut(mode)
		end
	end,
}
