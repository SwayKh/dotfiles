return {
  "otavioschwanck/arrow.nvim",
  keys = { ";", "<Cmd>Arrow open<CR>", desc = "Open Arrow menu" },
  config = function()
    require("arrow").setup({
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
      global_bookmarks = false,
      window = {
        border = "none",
      },
    })
  end,
}
