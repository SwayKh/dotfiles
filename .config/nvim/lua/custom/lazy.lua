vim.opt.termguicolors = true
require("lazy").setup({
  { import = "custom.plugins" },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },

  -- NOTE:First, some plugins that don't require any configuration

  "nvim-tree/nvim-web-devicons",
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
}, {})
