return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	lazy = { "BufWinEnter" },
	config = function()
		-- import telescope plugin safely
		local telescope = require("telescope")

		-- import telescope actions safely
		local actions = require("telescope.actions")

		-- import telescope-ui-select safely
		local themes = require("telescope.themes")

		-- keeps track of current `tabline` and `statusline`, so we can restore it after closing telescope
		local temp_showtabline
		local temp_laststatus

		function _G.global_telescope_find_pre()
			temp_showtabline = vim.o.showtabline
			temp_laststatus = vim.o.laststatus
			vim.o.showtabline = 0
			vim.o.laststatus = 0
		end

		function _G.global_telescope_leave_prompt()
			vim.o.laststatus = temp_laststatus
			vim.o.showtabline = temp_showtabline
		end

		vim.cmd([[
		    augroup MyAutocmds
		      autocmd!
		      autocmd User TelescopeFindPre lua global_telescope_find_pre()
		      autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua global_telescope_leave_prompt()
		    augroup END
		  ]])

		local function normalize_path(path)
			return path:gsub("\\", "/")
		end

		local function normalize_cwd()
			return normalize_path(vim.loop.cwd()) .. "/"
		end

		local function is_subdirectory(cwd, path)
			return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
		end

		local function split_filepath(path)
			local normalized_path = normalize_path(path)
			local normalized_cwd = normalize_cwd()
			local filename = normalized_path:match("[^/]+$")

			if is_subdirectory(normalized_cwd, normalized_path) then
				local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
				return stripped_path, filename
			else
				local stripped_path = normalized_path:sub(1, -(#filename + 1))
				return stripped_path, filename
			end
		end

		local function personal_path_display(_, path)
			local stripped_path, filename = split_filepath(path)
			if filename == stripped_path or stripped_path == "" then
				return filename
			end
			return string.format("%s ~ %s", filename, stripped_path)
		end

		-- configure telescope
		telescope.setup({
			-- configure custom mappings
			defaults = {
				-- path_display = { "tail" },
				file_ignore_patterns = { "node_modules", ".git" },
				path_display = personal_path_display,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
						["<CR>"] = function()
							vim.cmd([[:stopinsert]])
							vim.cmd([[call feedkeys("\<CR>")]])
						end,
					},
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						width = { padding = 0 },
						height = { padding = 0 },
						preview_width = 0.5,
					},
				},
				-- sorting_strategy = "ascending",
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" }) -- find previously opened files
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" }) -- find string in current working directory as you type
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers" }) -- list open buffers in current neovim instance
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		keymap.set(
			"n",
			"<leader>gfc",
			"<cmd>Telescope git_bcommits<cr>",
			{ desc = "Show git commits for current buffer" }
		) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" }) -- list current changes per file with diff preview ["gs" for git status]
	end,
}
