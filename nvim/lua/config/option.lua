--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

vim.g.mapleader = " " -- Set <space> as the leader key
vim.g.maplocalleader = " " -- Set <space> as the local leader key
vim.o.winborder = "rounded" -- Set default window borders for floating windows
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.autowrite = true -- If the same file is open in multiple file, autoupdate the changes
vim.opt.autoread = true -- Automatically reflect changes in files
vim.opt.colorcolumn = "0" -- Set a colorcolumn,
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.cursorlineopt = "number"
vim.opt.laststatus = 3 -- Always show statusline
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.tabline = " %t" -- Only show file name in tabline, not abbreviated path
vim.opt.spell = false -- set spell on
vim.opt.spelllang = "en_us"
vim.opt.filetype = "on" -- Automatically set the file, used for filetype autocmd
vim.opt.wrap = false
vim.opt.textwidth = 80 -- Set textwidth to Automatically wrap text at that length
vim.opt.whichwrap = "<,>,[,],l,h" -- Which characters can go through wrap on a line
vim.opt.termguicolors = true -- Set terminal colors to 24bit, needed for colorschemes
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Use relativenumber
vim.opt.numberwidth = 4 -- Width of numberline column
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%s%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%="
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
end)
vim.opt.formatoptions:remove("o") -- Don't have 'o' add a comment, From new tjdrevis video
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true
vim.opt.splitbelow = true -- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.scrolloff = 999 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 5
vim.opt.pumwidth = 80 -- Width of popup menu, like cmp menu
vim.opt.pumheight = 15 -- Max items to show in pop up menu
vim.opt.pumblend = 0 -- Transparency level for pop up menu
vim.opt.cmdheight = 1 -- Max items to show in command menu
vim.opt.updatetime = 250 -- Decrease update time, (Time before swap file is writter)
vim.opt.background = "dark" -- Set themes to dark
vim.opt.timeoutlen = 300 -- Displays which-key popup sooner, Decrease mapped sequence wait time
vim.opt.ttimeoutlen = 0
vim.opt.conceallevel = 3 -- Needed for Obsidian.nvim/markview.nvim to work properly
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.swapfile = false -- Disable swap file, allows file to edited by different windows
vim.opt.shortmess = "filnxtToOFs" -- I for Intro screen, See :h shortmess for detail
vim.opt.completeopt = "fuzzy,menuone,menu,noselect" -- Option for insert mode completion
vim.opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.jumpoptions = "stack,view"
vim.opt.splitkeep = "screen" -- Where to keep the cursor when opening a horizontal split
vim.opt.confirm = true -- Useful when buffers aren't written and I do :wq
vim.opt.showmatch = true
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
