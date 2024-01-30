return {
  "Exafunction/codeium.nvim",
  enabled = true,
  -- event = "InsertEnter",
  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
  end,
}
