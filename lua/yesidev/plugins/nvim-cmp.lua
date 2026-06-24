return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"onsails/lspkind.nvim",
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		-- load vs-code like snippets from plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/" } })

		vim.opt.completeopt = "menu,menuone,noselect"

		-- luasnip keymaps
		local keymap = vim.keymap
		local opt = { noremap = true, silent = true }
		keymap.set("i", "<Up>", "<cmd>lua require'luasnip'.jump(1)<Cr>", opt)
		keymap.set("i", "<Down>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", opt)

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone",
			},

			window = {
				completion = {
					side_padding = 1,
					border = border("CmpDocBorder"),
					winhighlight = "Normal:CmpPmenu,Search:PmenuSel",
				},
				documentation = {
					border = border("CmpDocBorder"),
					winhighlight = "Normal:CmpDoc",
				},
			},
			mapping = cmp.mapping.preset.insert({
				-- ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				-- ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<S-tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<tab>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
			}),

			-- auto-select the first completion item
			preselect = cmp.PreselectMode.None,

			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like icons
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					symbol_map = {
						Namespace = "󰌗",
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰆧",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈚",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰊄",
						Table = "",
						Object = "󰅩",
						Tag = "",
						Array = "[]",
						Boolean = "",
						Number = "",
						Null = "󰟢",
						String = "󰉿",
						Calendar = "",
						Watch = "󰥔",
						Package = "",
						Codeium = "",
						TabNine = "",
					},
				}),
			},
		})
	end,
}
