return {
  "Exafunction/codeium.nvim",
  enabled = false,
  event = "InsertEnter",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
  end,
}
