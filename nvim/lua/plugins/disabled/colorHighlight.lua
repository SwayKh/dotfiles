return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  config = function()
    local colorHighlight = require("nvim-highlight-colors")
    colorHighlight.setup({
      render = "background", -- 'foreground' or 'virtual' or 'background'
      enable_named_colors = true,
      enable_tailwind = false,
    })
  end,
}
