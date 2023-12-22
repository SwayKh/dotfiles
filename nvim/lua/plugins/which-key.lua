return {
  "folke/which-key.nvim",
  opts = {},
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup({
      window = {
        border = "double",
      },
    })
  end,
}
