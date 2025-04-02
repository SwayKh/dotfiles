--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.winborder = "rounded"

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- If the same file is open in multiple file, autoupdate the changes
vim.opt.autowrite = true
vim.opt.autoread = true

-- Set a colorcolumn,
vim.opt.colorcolumn = "0"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Always show statusline and tabline
vim.opt.laststatus = 3
vim.opt.showtabline = 2
-- Only show file name in tabline, not abbreviated path
vim.opt.tabline = " %t"

-- set spell on
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Automatically set the file, used for filetype autocmd
vim.opt.filetype = "on"

-- Set textwidth to Automatically wrap text at that length
vim.opt.textwidth = 80
-- Which characters can go through wrap on a line
vim.opt.whichwrap = "<,>,[,],l,h"

-- Set terminal colors to 24bit, needed for colorschemes
vim.opt.termguicolors = true

-- Make line numbers default, no relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- Width of numberline column
vim.opt.numberwidth = 2

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Don't have 'o' add a comment, From new tjdrevis video
vim.opt.formatoptions:remove("o")

-- Fix Tab length and Indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 5

-- Width of popup menu, like cmp menu
vim.opt.pumwidth = 80

-- Max items to show in pop up menu
vim.opt.pumheight = 15

-- Transparency level for pop up menu
vim.opt.pumblend = 0

-- Max items to show in command menu
vim.opt.cmdheight = 1

-- Decrease update time, (Time before swap file is writter)
vim.opt.updatetime = 250

-- Set themes to dark
vim.opt.background = "dark"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0

-- Needed for Obsidian.nvim to work properly
vim.opt.conceallevel = 3

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Disable swap file, allows file to edited by different windows
vim.opt.swapfile = false

-- Options for the starting screen on neovim. See :h shortmess for detail
vim.opt.shortmess = "filnxtToOFs" -- I for Intro screen

-- Option for insert mode completion
vim.opt.completeopt = "fuzzy,menuone,menu,noselect"

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Nice and simple folding:
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"

-- Something related to search
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum,fuzzy"

-- Disable "~" characters at end of buffer
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
  fold = "⠀",
  eob = " ",
  diff = "┃",
  msgsep = "‾",
  foldsep = "│",
  foldclose = "▶",
  foldopen = "▼",
}

vim.opt.jumpoptions = "stack,view"

-- Where to keep the cursor when opening a horizontal split
vim.opt.splitkeep = "screen"

-- Useful when buffers aren't written and I do :wq
vim.opt.confirm = true

vim.opt.showmatch = true
