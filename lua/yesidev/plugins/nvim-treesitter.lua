return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"HiPhish/nvim-ts-rainbow2",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting

				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["as"] = "@class.outer",
							["is"] = "@class.inner",
							["ic"] = "@conditional.inner",
							["ac"] = "@conditional.outer",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["at"] = "@comment.outer",
						},
					},

					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							[";f"] = "@function.outer",
							[";c"] = "@class.outer",
							[";i"] = "@conditional.outer",
							[";l"] = "@loop.*",
							[";t"] = "@comment.outer",
						},

						goto_previous_start = {
							[";ff"] = "@function.outer",
							[";cc"] = "@class.outer",
							[";ii"] = "@conditional.outer",
							[";ll"] = "@loop.*",
							[";tt"] = "@comment.outer",
						},

						goto_next_end = {
							["-f"] = "@function.outer",
							["-c"] = "@class.outer",
							["-i"] = "@conditional.outer",
							["-l"] = "@loop.outer",
							["-t"] = "@comment.outer",
						},

						goto_previous_end = {
							["--"] = "@function.outer",
							["-;"] = "@class.outer",
						},
					},

					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},

				highlight = {
					enable = true,
					disable = { "html" },
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- ensure these language parsers are installed
				ensure_installed = {
					"bash",
					"dockerfile",
					"gitignore",
					"html",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"terraform",
					"vim",
					"yaml",
				},
				-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				-- auto install above language parsers
				auto_install = true, -- enable nvim-ts-rainbow plugin

				rainbow = {
					enable = false,
					-- list of languages you want to disable the plugin for
					disable = { "jsx", "cpp", "html" },
					-- Which query to use for finding delimiters
					-- query = "rainbow-parens",
					-- Highlight the entire buffer all at once
					-- strategy = require("ts-rainbow").strategy.global,
				},
			})
		end,
	},
}
