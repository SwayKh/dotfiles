local map = vim.keymap.set

map("n", "<C-d>", "<C-d>zz", { desc = "Better half down scroll", remap = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Better half down scroll", remap = true })
map("x", "<leader>p", '"_dP', { desc = "Don't replace paste register when replacing something" })
