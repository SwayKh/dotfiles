vim.wo.wrap = false
vim.opt_local.wrap = false
vim.opt_local.showtabline = 0
vim.bo.buflisted = false
vim.opt_local.list = false
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.opt_local.spell = false

vim.keymap.set("n", "q", "<cmd>quit<CR>", { desc = "Man: Quit with q" })

vim.keymap.set("n", "<Leader>o", function()
  require("man").show_toc()
end, { desc = "Man: Populate qf with manpage headings" })
