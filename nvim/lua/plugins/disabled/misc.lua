return {

  { "j-hui/fidget.nvim" },
  { "tpope/vim-fugitive", lazy = false },
  { "tpope/vim-rhubarb", lazy = false },
  { "tpope/vim-sleuth", lazy = false },
  { "kevinhwang91/nvim-bqf" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("neoscroll").setup({})
    end,
  },
}
