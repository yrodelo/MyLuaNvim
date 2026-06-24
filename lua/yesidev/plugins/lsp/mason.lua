return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
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
			-- activa automáticamente (vim.lsp.enable) los servidores instalados.
			-- Reemplaza al antiguo automatic_installation de la v1.
			automatic_enable = true,
		})
	end,
}
