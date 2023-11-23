return {
  "rcarriga/nvim-notify",
  lazy = true,
  config = function()
    require("notify").setup({
      background_colour = "#3F67CF",
    })
  end,
}
