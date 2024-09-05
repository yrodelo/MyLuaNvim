return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		local bufferline = require("bufferline")
		require("bufferline").setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				-- separator_style = { "", "" }, --"slant" | "thick" | "thin" | { '', '' }`
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " 󰅙" or " "
					return " " .. count .. icon
				end,
				style_preset = {
					bufferline.style_preset.no_bold,
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_buffer_close_icons = false,
				diagnostics_update_in_insert = false,
			},
		})

		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }

		opts.desc = "tab next"
		keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", opts)

		opts.desc = "tab prev"
		keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", opts)

		opts.desc = "close all tabs"
		keymap.set("n", "t", "<cmd>BufferLineCloseOthers<CR>", opts)

		opts.desc = "close actual tab"
		keymap.set("n", "<C-c>", "<cmd>bd<CR>", opts)
	end,
}
