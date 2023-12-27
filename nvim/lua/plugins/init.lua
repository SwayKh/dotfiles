return {
  -- {
  --   "plugin/shorthand",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetype = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          -- mode = "background", -- Set the display mode.
          mode = "virtualtext", -- Set the display mode.
          virtualtext = "",
        },
        buftypes = {},
      })
    end,
  },
  { "christoomey/vim-tmux-navigator", lazy = false },

  { "tpope/vim-fugitive", lazy = false, enabled = false },
  { "tpope/vim-rhubarb", lazy = false, enabled = false },
  { "tpope/vim-sleuth", lazy = false, enabled = false },
  { "kevinhwang91/nvim-bqf", lazy = true, enabled = false },
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
