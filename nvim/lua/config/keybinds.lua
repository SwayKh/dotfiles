-- [[ Basic Keymaps ]]

local map = vim.keymap.set

-- Misc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>m", "@@", { silent = true, desc = "Run last [M]acro, @@ is awkward" })
map("n", "<leader>.", "<Cmd>source %<CR>", { silent = true, desc = "Source nvim config, and reload all plugins" })

-- Move selected text up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move through long lines of text visually
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Scroll keybinds
map({ "n", "v" }, "<M-j>", "5j", { desc = "Scroll 5 lines" })
map({ "n", "v" }, "<M-k>", "5k", { desc = "Scroll 5 lines" })
map({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Better half up scroll", remap = true })
map({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Better half down scroll", remap = true })

-- Increment/Decreament
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decreament number" })

-- Split keybinds, Need to figure out a better system
map("n", "<leader>V", "<Cmd>vsplit<CR>", { desc = "Split [V]ertically" })
map("n", "<leader>H", "<Cmd>split<CR>", { desc = "Split [H]orizontally" })

--Select all/Yank all/Custom paste
map("n", "<leader>a", "gg<S-v>G", { desc = "Select all", remap = true })
map("n", "<leader>y", "<Cmd>%y+<CR>", { silent = true, desc = "Copy whole file" })
map("x", "P", [[<Cmd>silent! normal! "_dP<CR>]], { noremap = true, silent = true })
-- map("x", "<leader>p", '"_dP', { silent = true, desc = "Don't replace paste register when replacing something" })

-- Save, Quit and Delete
map("n", "qq", "<Cmd>q!<CR>", { silent = true, desc = "[Q]uit" })
map("n", "<leader>bd", "<Cmd>bd<CR>", { silent = true, desc = "Run [B]buffer [D]elete" })
map({ "n", "i", "v" }, "<C-s>", "<ESC><Cmd>w!<CR>", { silent = true, desc = "[S]ave file" })
map({ "n", "i", "v" }, "<C-q>", "<ESC><Cmd>wqa!<CR>", { silent = true, desc = "Save all files [Q]uit" })

-- Open Lazy/Mason UIs and reload plugins
map("n", "<leader>;l", "<Cmd>Lazy<CR>", { silent = true, desc = "Open [L]azy" })
map("n", "<leader>;m", "<Cmd>Mason<CR>", { silent = true, desc = "Open [M]ason" })
map("n", "<leader>lr", ":Lazy reload", { desc = "[L]azy [R]eload plugin of choice" })

-- Quickfix list keybinds
map("n", "<leader>cn", "<Cmd>cnext<CR>", { desc = "Go to next item in Quickfix list" })
map("n", "<leader>cp", "<Cmd>cprev<CR>", { desc = "Go to previous item in Quickfix list" })
map("n", "<leader>co", "<Cmd>copen<CR>", { desc = "Open Quickfix List" })
map("n", "<leader>cc", "<Cmd>cclose<CR>", { desc = "Close Quickfix List" })

-- Go to Beginning or End of line
map({ "n", "v" }, "H", "_^", { desc = "Move to the beginning of the line" })
map({ "n", "v" }, "L", "$", { desc = "Move to the end of the line" })

-- Move in insert mode
map("i", "<C-j>", "<Down>", { desc = "Move Down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move Up in insert mode" })
map("i", "<C-h>", "<Left>", { desc = "Move Left in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move Right in insert mode" })

-- Move between splits
map("n", "<C-j>", "<C-w>j", { desc = "Move Between splits with HJKL" })
map("n", "<C-k>", "<C-w>k", { desc = "Move Between splits with HJKL" })
map("n", "<C-h>", "<C-w>h", { desc = "Move Between splits with HJKL" })
map("n", "<C-l>", "<C-w>l", { desc = "Move Between splits with HJKL" })

-- Split Resize
map("n", "<C-S-h>", "<C-w>>") -- resize window to left
map("n", "<C-S-l>", "<C-w><") -- resize window to right
map("n", "<C-S-k>", "<C-w>+") -- resize window to up
map("n", "<C-S-j>", "<C-w>-") -- resize window to down
map("n", "<C-S-Left>", "<Cmd>vertical resize +3<CR>") -- Control+Left resizes vertical split +
map("n", "<C-S-Right>", "<Cmd>vertical resize -3<CR>") -- Control+Right resizes vertical split -

map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Remap common typos when saving and closing files
vim.cmd("cnoreabbrev Q  q")
vim.cmd("cnoreabbrev q1  q!")
vim.cmd("cnoreabbrev Q1  q!")
vim.cmd("cnoreabbrev Qa1 qa!")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")

-- Autocomplete brackets and quotes
-- Feels annoying somehow, autopair plugin is better
-- map("i", "'", "''<left>")
-- map("i", '"', '""<left>')
-- map("i", "(", "()<left>")
-- map("i", "[", "[]<left>")
-- map("i", "{", "{}<left>")
-- map("i", "{;", "{};<left><left>")
-- map("i", "/*", "/**/<left><left>")

-- This overrides to <C-i> function of the jumplist
-- map("n", "<tab>", "<cmd>b#<cr>", { desc = "Switch to last buffer" })

-- Don't ever use this, plus M is being used by Flash
-- map(
--   { "n", "v" },
--   "M",
--   "<Cmd>call cursor(0, virtcol('$')/2)<CR>",
--   { silent = true, desc = "Move to the middle of the line" }
-- )
