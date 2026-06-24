vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap

local function map(mode, shortcut, command, desc)
	keymap.set(mode, shortcut, command, { desc = desc, noremap = true, silent = true })
end

local function noremap(shortcut, command, desc)
	map({ "n", "v" }, shortcut, command, desc)
end

local function nmap(shortcut, command, desc)
	map("n", shortcut, command, desc)
end

local function imap(shortcut, command, desc)
	map("i", shortcut, command, desc)
end

-- save
nmap("<leader>w", "<cmd>w<CR>", "save")
nmap("<leader>q", "<cmd>q<CR>", "close")
nmap("<leader>Q", "<cmd>q!<CR>", "force quit")

-- source
nmap("<leader>%", ":source%<CR>", "load source")

-- esc noh
nmap("<ESC>", "<cmd>noh<CR>")

-- enter in n mode
nmap("<CR>", "o<Esc>")

-- tmux navigator
nmap("<C-h>", "<cmd>tmuxNavigateLeft<CR>", "window left")
nmap("<C-j>", "<cmd>tmuxNavigateDown<CR>", "window down")
nmap("<C-k>", "<cmd>tmuxNavigateUp<CR>", "window up")
nmap("<C-l>", "<cmd>tmuxNavigateRight<CR>", "window right")

-- begin and end of line
noremap("<leader>h", "^", "begin of line")
noremap("<leader>l", "g_", "end of line")

-- for go vars
imap(",.", ":=", "go var")

-- persistent copy
noremap("<leader>p", '"0p', "paste with persistent copy")
