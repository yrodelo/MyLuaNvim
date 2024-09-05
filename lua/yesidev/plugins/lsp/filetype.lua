return {
	"nathom/filetype.nvim",
	config = function()
		require("filetype").setup({
			overrides = {
				extensions = {
					tf = "terraform",
					tfvars = "terraform",
					tfstate = "json",
					sh = "bash",
					-- html = "html",
					html = "htmldjango",
				},
				complex = {
					-- Set the filetype of any full filename matching the regex to gitconfig
					["Dockerfile.*"] = "dockerfile", -- Included in the plugin
					[".*_django.html$"] = "htmldjango", -- Añade esta línea
				},
			},
		})
	end,
}
