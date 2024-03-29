return {

  { "j-hui/fidget.nvim", opts = {}, enabled = false },
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
    enabled = false,
    config = function()
      require("neoscroll").setup({})
    end,
  },
}
