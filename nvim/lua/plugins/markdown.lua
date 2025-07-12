local presets = require("markview.presets")
require("markview").setup({
  markdown = {
    headings = presets.headings.arrowed,
    horizontal_rules = presets.horizontal_rules.thick,
    tables = presets.tables.rounded,
  },
  preview = {
    icon_provider = "mini", -- "mini" or "devicons"
  },
})
vim.keymap.set("n", "<leader>mp", ":Markview<CR>", { desc = "Preview Markdown" })
