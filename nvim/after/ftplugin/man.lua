vim.wo.wrap = false
vim.opt_local.wrap = false
vim.opt_local.showtabline = 0
vim.opt_local.list = false
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.opt_local.spell = false

vim.keymap.set("n", "<Leader>o", function()
  require("man").show_toc()
end, { desc = "Man: Show table of content" })
