return {
	"nvim-tree/nvim-tree.lua",
	event = { "BufWinEnter" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "~", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("open folder"))
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("close folder"))
			vim.keymap.set("n", "v", api.node.open.vertical, opts("vertical split"))
			vim.keymap.set("n", "_", api.node.open.horizontal, opts("horizontal split"))
			vim.keymap.set("n", "o", api.node.open.preview, opts("preview"))
			vim.keymap.set("n", "M", api.marks.bulk.move, opts("move file"))
			vim.keymap.set("n", "t", api.node.open.tab, opts("open new tab"))
		end

		-- configure nvim-tree
		nvimtree.setup({
			on_attach = my_on_attach,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			view = {
				width = 35,
				relativenumber = true,
				side = "right",
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
							default = "",
							open = "",
						},
						git = {
							unstaged = "M",
							staged = "A",
							unmerged = "",
							renamed = "➜",
							untracked = "●",
							deleted = "D",
							ignored = "◌",
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "toggle file explorer" }) -- toggle file explorer on current file
	end,
}
