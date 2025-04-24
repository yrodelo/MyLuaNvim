local dev_experience = {
	-- -- for go
	-- {
	-- 	"olexsmir/gopher.nvim",
	-- 	ft = "go",
	-- 	config = function()
	-- 		require("gopher").setup()
	-- 	end,
	-- 	build = function()
	-- 		vim.cmd([[silent! GoInstallDeps]])
	-- 	end,
	-- 	keys = {
	-- 		{ mode = "n", "<leader>gtj", "<cmd> GoTagAdd json <CR>", desc = "Add json struct tags" },
	-- 		{ mode = "n", "<leader>gty", "<cmd> GoTagAdd json <CR>", desc = "Add yaml struct tags" },
	-- 	},
	-- },
	{
		"hashivim/vim-terraform",
		lazy = false,
		config = function()
			vim.g["terraform_align"] = 1
			vim.g["terraform_fmt_on_save"] = 1
		end,
	},
}

return dev_experience
