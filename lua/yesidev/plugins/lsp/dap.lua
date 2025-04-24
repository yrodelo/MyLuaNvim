return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		-- "leoluz/nvim-dap-go",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "watches",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "scopes",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})
		-- require("dap-go").setup()
		require("nvim-dap-virtual-text").setup()

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)

		local keymap = vim.keymap -- for conciseness
		local opts = { noremap = true, silent = true }

		opts.desc = "Debug: Step Into"
		keymap.set("n", "<F1>", dap.step_into, opts)

		opts.desc = "Debug: Step Over"
		keymap.set("n", "<F2>", dap.step_over, opts)

		opts.desc = "Debug: Step Out"
		keymap.set("n", "<F3>", dap.step_out, opts)

		opts.desc = "Debug: Restart"
		keymap.set("n", "<F4>", dap.run_last, opts)

		opts.desc = "Debug: Clear Breakpoints"
		keymap.set("n", "<F5>", dap.clear_breakpoints, opts)

		opts.desc = "Debug: Toggle Breakpoint"
		keymap.set("n", "<F6>", dap.toggle_breakpoint, opts)

		opts.desc = "Toggle dap ui"
		keymap.set("n", "<F7>", dapui.toggle, opts)

		opts.desc = "Debug: Start/Continue"
		keymap.set("n", "<F8>", dap.continue, opts)

		opts.desc = "Debug: Terminate"
		keymap.set("n", "<F10>", dap.terminate, opts)
	end,
}
