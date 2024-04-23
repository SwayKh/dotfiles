--Need this to be loaded before some plugins, but option.lua needs colorscheme to be loaded
-- vim.opt.termguicolors = true

require("config.option")
require("config.keybinds")
require("config.misc")
require("config.lazy")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
