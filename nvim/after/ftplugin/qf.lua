vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "no"
vim.o.cursorline = true

vim.keymap.set("n", "q", function()
  vim.cmd("q")
end)
