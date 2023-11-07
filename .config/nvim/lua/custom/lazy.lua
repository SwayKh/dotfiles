require('lazy').setup({
  -- NOTE:First, some plugins that don't require any configuration

  { 'ThePrimeagen/vim-be-good' },
  { 'ms-jpq/chadtree' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'rcarriga/nvim-notify' },
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },

  -- Colorschemes
  { 'tanvirtin/monokai.nvim' },
  { 'navarasu/onedark.nvim' },
  { 'sainnhe/gruvbox-material' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'shaunsingh/nord.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'Mofiqul/dracula.nvim' },
  { 'tanvirtin/monokai.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin' },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { import = 'custom.plugins' },
}, {})
