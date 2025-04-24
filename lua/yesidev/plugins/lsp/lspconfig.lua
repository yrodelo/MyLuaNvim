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

		require("inc_rename").setup()

		local keymap = vim.keymap -- for conciseness

		-- enable keybinds only for when lsp server available
		-- keybind options
		local opts = { noremap = true, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", ":IncRename ", opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

		opts.desc = "show diagnostic"
		keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- hide error on screen
		vim.diagnostic.config({
			virtual_text = false,
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

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = {
				-- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		-- yamlls
		--[[ lspconfig["yamlls"].setup({
			capabilities = capabilities,
			settings = {
				yaml = {
					schemaStore = {
						-- You must disable built-in schemaStore support if you want to use
						-- this plugin and its advanced options like `ignore`.
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		}) ]]

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
							-- "/*.azure*",
							"/build.y*l",
							-- "Azure-Pipelines/**/*.y*l",
							-- "Pipelines/*.y*l",
							-- "*.y*l",
						},
					},
				},
				format = {
					enable = true,
				},
			},
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

		-- lspconfig["gopls"].setup({
		-- 	capabilities = capabilities,
		-- })

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

		-- disable diagnostics for tfvars
		local ng = require("ng")

		opts.desc = "Go to template for component"
		vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)

		opts.desc = "Go to component with template file"
		vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)

		opts.desc = "Get template TCB"
		vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
	end,
}
