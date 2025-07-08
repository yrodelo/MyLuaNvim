return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"smjonas/inc-rename.nvim",
		"joeveiga/ng.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- ## CONFIGURACIÓN DE LUA_LS (MOVIDA AL PRINCIPIO) ##
		-- Configura el servidor de Lua primero para que reconozca el global 'vim' en este archivo.
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- El resto de la configuración
		require("inc_rename").setup()
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", ":IncRename ", opts)

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

		opts.desc = "show diagnostic"
		keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

		-- Configura los diagnósticos y define los iconos
		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- enable/disable diagnostics
		vim.g.diagnostic_enabled = true

		vim.api.nvim_exec(
			[[
    function! ToggleDiagnostic()
        if g:diagnostic_enabled
            lua vim.diagnostic.disable()
        else
            lua vim.diagnostic.enable()
        endif
        let g:diagnostic_enabled = !g:diagnostic_enabled
    endfunction
    ]],
			false
		)

		-- shortcut
		opts.desc = "Enable/disable diagnostics"
		vim.keymap.set("n", "<leader>ad", "<cmd>:call ToggleDiagnostic()<CR>", opts)

		--## LSP Servers ##--

		lspconfig["azure_pipelines_ls"].setup({
			capabilities = capabilities,
			root_dir = function()
				return vim.fn.getcwd()
			end,
			settings = {
				yaml = {
					schemas = {
						["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] = {
							".github/**/*.y*l",
						},
						["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
							"/azure-pipeline*.y*l",
							"/build.y*l",
						},
					},
				},
				format = {
					enable = true,
				},
			},
		})

		lspconfig["yamlls"].setup({
			capabilities = capabilities,
		})

		-- disable virtual text for azure pipelines
		vim.api.nvim_exec(
			[[
    augroup azure_pipelines_config
        autocmd!
        autocmd BufEnter *.y*ml lua vim.diagnostic.config({ virtual_text = false })
      ]],
			false
		)

		lspconfig["bashls"].setup({
			capabilities = capabilities,
		})

		lspconfig["jsonls"].setup({
			capabilities = capabilities,
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
		})

		lspconfig["html"].setup({
			capabilities = capabilities,
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
		})

		lspconfig["angularls"].setup({
			capabilities = capabilities,
		})

		lspconfig["terraformls"].setup({
			capabilities = capabilities,
		})

		local ng = require("ng")

		opts.desc = "Go to template for component"
		vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)

		opts.desc = "Go to component with template file"
		keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)

		opts.desc = "Get template TCB"
		keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
	end,
}
