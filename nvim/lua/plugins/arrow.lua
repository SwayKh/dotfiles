require("arrow").setup({
  show_icons = true,
  leader_key = ";", -- Recommended to be a single key
  buffer_leader_key = "m", -- Per Buffer Mappings
  global_bookmarks = false,
  window = {
    border = vim.g.border_style,
  },
})
