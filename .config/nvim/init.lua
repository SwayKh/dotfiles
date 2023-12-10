vim.g.mapleader = " "
vim.g.maplocalleader = " "
--Need this to be loaded before some plugins, but option.lua needs colorscheme to be loaded
vim.opt.termguicolors = true

require("custom.lazy")
require("custom.remap")
require("custom.option")
require("custom.misc")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
