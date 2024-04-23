-- [[ Setting options ]]
-- See `:help vim.o`

vim.g.have_nerd_font = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.colorcolumn = "120"
vim.opt.cursorline = false
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.spell = false -- set spell on
vim.opt.spelllang = "en_us"
vim.opt.filetype = "on"
vim.opt.wrap = true -- enable text wrapping
vim.opt.breakindent = true
vim.opt.textwidth = 80
vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.opt.numberwidth = 2
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 5
vim.wo.signcolumn = "yes"
vim.opt.pumwidth = 50
vim.opt.pumheight = 0 -- Max items to show in pop up menu
vim.opt.cmdheight = 0 -- Max items to show in command menu
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0
vim.opt.conceallevel = 0
vim.opt.showmode = true
vim.opt.swapfile = false
vim.opt.shortmess = "filnxtToOFsI"
vim.opt.completeopt = "menuone,menu,noselect"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }
-- Fix Tab length
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = false
