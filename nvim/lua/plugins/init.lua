return {
  -- {
  --   "plugin/shorthand",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "tpope/vim-fugitive", lazy = false },
  { "tpope/vim-rhubarb", lazy = false },
  { "tpope/vim-sleuth", lazy = false },
  { "christoomey/vim-tmux-navigator", lazy = false },
  { "NvChad/nvim-colorizer.lua", config = true },
  { "kevinhwang91/nvim-bqf" },
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
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        sticky = true,
        padding = true,
        toggler = {
          line = "<M-/>",
        },
        opleader = {
          line = "<M-/>",
        },
        mappings = {
          basic = true,
          extra = true,
        },
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    enabled = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("neoscroll").setup({})
    end,
  },
}
