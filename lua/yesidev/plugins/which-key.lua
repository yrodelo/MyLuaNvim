return {
	"folke/which-key.nvim",
	event = "BufWinEnter",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		icons = {
			-- habilita iconos por mapping (también los que vienen de reglas)
			mappings = true,
			-- Iconografía centralizada. El `pattern` (patrón Lua, en minúsculas) se
			-- compara contra la descripción del keymap; la PRIMERA coincidencia gana,
			-- por eso van de más específico a más genérico. Todos los glifos son
			-- Nerd Font (rango nf-md / Material Design). Cualquier keymap no cubierto
			-- aquí cae en las reglas internas de which-key como respaldo.
			---@type wk.IconRule[]
			rules = {
				-- plugins / contextos específicos
				{ pattern = "nvim%-tree", icon = "󰙅", color = "green" }, -- mappings del árbol
				{ pattern = "explorer", icon = "󰙅", color = "green" }, -- toggle file explorer
				{ pattern = "lazygit", icon = "󰊢", color = "red" },
				{ pattern = "harpoon", icon = "󰀱", color = "cyan" },
				{ pattern = "hop", icon = "󰉁", color = "yellow" },

				-- depuración (DAP)
				{ pattern = "debug", icon = "󰃤", color = "red" },
				{ pattern = "dap", icon = "󰃤", color = "red" },

				-- LSP / diagnósticos / código
				{ pattern = "diagnostic", icon = "󱖫", color = "green" },
				{ pattern = "lsp", icon = "󰒋", color = "blue" },
				{ pattern = "rename", icon = "󰑕", color = "purple" },
				{ pattern = "code", icon = "󰌵", color = "orange" }, -- code actions
				{ pattern = "documentation", icon = "󰋖", color = "blue" }, -- hover docs
				{ pattern = "declaration", icon = "󰈇", color = "azure" },
				-- Angular (ng.nvim): plantillas y componentes
				{ pattern = "template", icon = "󰅴", color = "red" },
				{ pattern = "component", icon = "󰏖", color = "red" },

				-- treesitter textobjects (swap / select / move)
				{ pattern = "swap", icon = "󰓡", color = "purple" },
				{ pattern = "parameter", icon = "󰀫", color = "blue" },
				{ pattern = "function", icon = "󰊕", color = "blue" },
				{ pattern = "class", icon = "󰠱", color = "blue" },
				{ pattern = "conditional", icon = "󰅩", color = "blue" },
				{ pattern = "loop", icon = "󰑖", color = "blue" },
				{ pattern = "comment", icon = "󰅺", color = "grey" },

				-- edición / formato / plegado
				{ pattern = "fold", icon = "󰅀", color = "yellow" },
				{ pattern = "format", icon = "󰉢", color = "cyan" },
				{ pattern = "paste", icon = "󰅌", color = "yellow" },
				{ pattern = "go var", icon = "󰀫", color = "blue" },
				{ pattern = "of line", icon = "󰉿", color = "grey" },

				-- buffers / pestañas / git / búsqueda
				{ pattern = "tab", icon = "󰓩", color = "purple" },
				{ pattern = "git", icon = "󰊢", color = "orange" },
				{ pattern = "buffer", icon = "󰈔", color = "cyan" },
				{ pattern = "find", icon = "󰍉", color = "green" },
				{ pattern = "string", icon = "󰍉", color = "green" },

				-- archivo / sesión / ventanas
				{ pattern = "save", icon = "󰆓", color = "green" },
				{ pattern = "source", icon = "󰑓", color = "cyan" },
				{ pattern = "window", icon = "󰖯", color = "blue" },
				{ pattern = "quit", icon = "󰗼", color = "red" },

				-- genéricos (al final, para no pisar a los anteriores)
				{ pattern = "close", icon = "󰅖", color = "red" },
				{ pattern = "toggle", icon = "󰔡", color = "yellow" },
			},
		},
	},
}
