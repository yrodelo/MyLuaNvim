local set = vim.opt

-- line numbers
set.number = true
set.relativenumber = true

-- tabs & indentation
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true

-- seach settings
set.ignorecase = true
set.smartcase = true

-- cursor line
set.cursorline = false

-- appearance
set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"

-- for copilot chat
set.laststatus = 3
set.splitkeep = "screen"

-- folding
set.foldenable = true
set.foldcolumn = "1"
set.foldlevel = 99
set.foldlevelstart = 99

-- remove auto comment below
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- backspace
set.backspace = "indent,eol,start"

set.clipboard:append("unnamedplus")

-- same word
set.iskeyword:append("-", "_")

-- split windows
set.splitright = true -- split vertical window to the right
set.splitbelow = true -- split horizontal window to the bottom

-- turn off swap file
set.swapfile = false

-- no show status line
set.showmode = false

-- check speller
set.spelllang = "en_us,es"
set.spell = true

-- own global variables
vim.g.auto_format = 1
