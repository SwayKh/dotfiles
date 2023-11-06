-- [[ Setting options ]]
-- See `:help vim.o`

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.colorcolumn = '120'
vim.opt.laststatus = 3

-- Fix Tab length
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Keep scape above and below when scrolling
vim.opt.scrolloff = 10

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
