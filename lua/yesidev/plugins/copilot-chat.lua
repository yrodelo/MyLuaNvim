return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		event = { "BufWinEnter" },
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		opts = {
			-- See Configuration section for rest
			-- show_help = false,
		},
		keys = {
			-- Show help actions with telescope
			-- Quick chat with Copilot
			{
				"<leader>ccq",
				":CopilotChatOpen<cr>",
				desc = "CopilotChat - Toggle",
			},
			-- Quick chat with Copilot using visual selection
			{
				"<leader>cc",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
					end
				end,
				desc = "CopilotChat - Quick chat",
				mode = "v",
			},
			{
				"<leader>ccs",
				":CopilotChatSave ",
				desc = "CopilotChat - Save",
			},
			{
				"<leader>ccl",
				":CopilotChatLoad ",
				desc = "CopilotChat - Load",
			},
		},
	},
}
