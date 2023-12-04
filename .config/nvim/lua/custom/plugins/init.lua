-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Git related plugins
  {
    "tpope/vim-fugitive",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "tpope/vim-rhubarb",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    -- Need this for css color highlighting, Can't get treesitter to work
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    enabled = true,
  },
  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    opts = {
      sticky = true,
      padding = true,
      toggler = {
        line = "<C-/>",
      },
      mappings = {
        basic = true,
        extra = true,
      },
    },
    event = { "BufReadPre", "BufNewFile" },
  },
}
