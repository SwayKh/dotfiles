return {
  "folke/which-key.nvim",
  opts = {},
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup({
      window = {
        border = "single",
      },
    })
  end,
}
