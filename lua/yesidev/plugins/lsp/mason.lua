return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import mason plugin
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason
		mason.setup()

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- languages
				"yamlls",
				"azure_pipelines_ls",
				"bashls",
				"cssls",
				"emmet_ls",
				"html",
				"jsonls",
				"lua_ls",
				"pyright",
				"terraformls",
				"ts_ls",
				-- "gopls",

				-- frameworks
				"angularls",
				"tailwindcss",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
	end,
}
