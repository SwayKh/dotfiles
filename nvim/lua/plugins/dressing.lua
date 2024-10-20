return {
  "stevearc/dressing.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("dressing").setup()
  end,
}
