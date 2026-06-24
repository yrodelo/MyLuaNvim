return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"smjonas/inc-rename.nvim",
		"joeveiga/ng.nvim",
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- ## API nativa de Neovim 0.11+ ##
		-- En lugar de require("lspconfig").<server>.setup(), ahora se usa
		-- vim.lsp.config() para definir/extender configuraciones y
		-- vim.lsp.enable() para activarlas. nvim-lspconfig sólo aporta las
		-- definiciones base en runtimepath (lsp/<server>.lua).

		-- Aplica las capabilities de cmp a TODOS los servidores.
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- ## Overrides por servidor ##

		-- lua_ls: reconoce el global `vim` y la librería de runtime de Neovim.
		vim.lsp.config("lua_ls", {
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

		-- azure_pipelines_ls: fuerza el root al cwd y define los schemas.
		vim.lsp.config("azure_pipelines_ls", {
			root_dir = function(_, on_dir)
				on_dir(vim.fn.getcwd())
			end,
			settings = {
				yaml = {
					schemas = {
						["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] = {
							".github/**/*.y*l",
						},
						["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
							"/azure-pipeline*.y*l",
							"**/build.y*l",
							"master-extends.y*l",
						},
					},
				},
				format = {
					enable = true,
				},
			},
		})

		-- Los servidores se instalan vía mason-lspconfig (ensure_installed) y se
		-- activan automáticamente con su opción automatic_enable (ver mason.lua).

		-- inc-rename
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
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

		opts.desc = "show diagnostic"
		keymap.set("n", "gl", vim.diagnostic.open_float, opts)

		-- Configura los diagnósticos y define los iconos
		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- enable/disable diagnostics (API nativa 0.11+: enable recibe un booleano)
		opts.desc = "Enable/disable diagnostics"
		vim.keymap.set("n", "<leader>ad", function()
			vim.diagnostic.enable(not vim.diagnostic.is_enabled())
		end, opts)

		-- disable virtual text for yaml/azure pipelines buffers
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("azure_pipelines_config", { clear = true }),
			pattern = { "*.yml", "*.yaml" },
			callback = function()
				vim.diagnostic.config({ virtual_text = false })
			end,
		})

		-- ng.nvim (Angular helpers)
		local ng = require("ng")

		opts.desc = "Go to template for component"
		vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)

		opts.desc = "Go to component with template file"
		keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)

		opts.desc = "Get template TCB"
		keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
	end,
}
