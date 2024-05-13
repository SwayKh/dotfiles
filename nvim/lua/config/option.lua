-- [[ Setting options ]]
-- See `:help vim.o`
-- Add comments to detail to options

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Show highlighted search terms as you type
vim.opt.incsearch = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- If the same file is open in multiple file, autoupdate the changes
vim.opt.autowrite = true
vim.opt.autoread = true

-- Set a colorcolumn, I like mine at 120
vim.opt.colorcolumn = "120"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Always show statusline and tabline
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.tabline = " %t"

-- set spell on
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Automaticaly set the file, used for filetype autocmd
vim.opt.filetype = "on"

-- enable text wrapping, Wrap text at 80 characters
vim.opt.wrap = true
vim.opt.textwidth = 80

-- Set terminal colors to 24bit, needed for colorschemes
vim.opt.termguicolors = true

-- Make line numbers default, no relativenumber
vim.opt.number = true
vim.opt.relativenumber = false

-- Width of numberline column
vim.opt.numberwidth = 2

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Don't have 'o' add a commment, From new tjdrevis video
vim.opt.formatoptions:remove("o")

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 5

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Width of pupup menu, like cmp menu
vim.opt.pumwidth = 50

-- Max items to show in pop up menu
vim.opt.pumheight = 0

-- Max items to show in command menu
vim.opt.cmdheight = 0

-- Decrease update time, (Time before swap file is writter)
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0
vim.opt.conceallevel = 0

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Disable swap file, allows file to edited by different windows
vim.opt.swapfile = false

-- Options for the starting screen on neovim. See :h shortmess for detail
vim.opt.shortmess = "filnxtToOFsI"

-- Option for insert mode completion
vim.opt.completeopt = "menuone,menu,noselect"

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Disable "~" characters at end of buffer
vim.opt.fillchars = { eob = " " }

-- Fix Tab length and Indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = false
