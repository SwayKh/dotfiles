return {
  "karb94/neoscroll.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("neoscroll").setup({})
  end,
}
