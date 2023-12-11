-- [[ Setting options ]]
-- See `:help vim.o`
vim.cmd.colorscheme("catppuccin-macchiato")
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.colorcolumn = "120"
vim.opt.laststatus = 3
vim.o.pumheight = 10 -- Max items to show in pop up menu
vim.o.cmdheight = 0 -- Max items to show in command menu
vim.opt.spell = false -- set spell on
vim.opt.spelllang = "en_us"
vim.opt.wrap = true -- enable text wrapping
vim.opt.breakindent = true
vim.opt.textwidth = 80
vim.o.fileencoding = "utf-8"
vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 10
vim.wo.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Fix Tab length
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.showtabline = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = false

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"
