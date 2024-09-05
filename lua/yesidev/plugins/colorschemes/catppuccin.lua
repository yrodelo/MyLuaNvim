return {
	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = { "bold" },
					keywords = {},
					strings = {},
					variables = {},
					numbers = { "italic" },
					booleans = { "italic" },
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					alpha = true,
					ts_rainbow2 = true,
					mason = true,
					which_key = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- load the colorscheme here
			vim.cmd.colorscheme("catppuccin")

			-- change line numbers color
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6c7086" })
			vim.api.nvim_set_hl(0, "LineNr", { fg = "#6c7086" })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6c7086" })
		end,
	},
}
