return {
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
}
