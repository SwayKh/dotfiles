-- [[ Basic Keymaps ]]

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("v", "<space>sl", ":lua<CR>", { desc = "Execute [S]elected lua lines" })
map("n", "<space>sl", "<Cmd>.lua<CR>", { desc = "Execute [S]elected lua lines" })
map("n", "<leader>so", "<Cmd>source %<CR>", { silent = true, desc = "[So]urce current file" })

map("n", "<C-c>", "<Cmd>close<CR>", { silent = true, desc = "Close window" })

-- Go to Beginning or End of line
map({ "n", "v" }, "H", "_^", { desc = "Move to the beginning of the line" })
map({ "n", "v" }, "L", "$", { desc = "Move to the end of the line" })

-- Move between splits
map("n", "<C-j>", "<C-w>j", { desc = "Move Between splits with HJKL" })
map("n", "<C-k>", "<C-w>k", { desc = "Move Between splits with HJKL" })
map("n", "<C-h>", "<C-w>h", { desc = "Move Between splits with HJKL" })
map("n", "<C-l>", "<C-w>l", { desc = "Move Between splits with HJKL" })

-- Move in insert mode, And Command-line mode
map({ "i", "c" }, "<C-j>", "<Down>", { desc = "Move Down in insert mode" })
map({ "i", "c" }, "<C-k>", "<Up>", { desc = "Move Up in insert mode" })
map({ "i", "c" }, "<C-h>", "<Left>", { desc = "Move Left in insert mode" })
map({ "i", "c" }, "<C-l>", "<Right>", { desc = "Move Right in insert mode" })

-- Move selected text up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move through long lines of text visually
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Indenting keeps selections
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Split keybinds, Need to figure out a better system
map("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split [V]ertically" })
map("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split [H]orizontally" })

--Select all/Yank all/Custom paste
map("n", "<leader>a", "gg<S-v>G", { desc = "Select all", remap = true })
map("n", "<leader>y", "<Cmd>%y+<CR>", { silent = true, desc = "Copy whole file" })
map("x", "P", [[<Cmd>silent! normal! "_dP<CR>]], { noremap = true, silent = true })

-- Search and replace word under the cursor.
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "[R]eplace [W]ord under cursor" })

-- Save, Quit
map("n", "qq", "<Cmd>%bd<CR><Cmd>lua Snacks.dashboard()<CR>", { silent = true, desc = "Delete all buffers" })
map({ "n", "i", "v" }, "<C-s>", "<ESC><Cmd>w!<CR>", { silent = true, desc = "[S]ave all files" })
map({ "n", "i", "v" }, "<C-q>", "<ESC><Cmd>wqa!<CR>", { silent = true, desc = "Save all file and [Q]uit" })

-- Quickfix list keybinds
map("n", "<leader>cn", "<Cmd>cnext<CR>", { desc = "Go to next item in Quickfix list" })
map("n", "<leader>cp", "<Cmd>cprev<CR>", { desc = "Go to previous item in Quickfix list" })
map("n", "<leader>co", "<Cmd>copen<CR>", { desc = "Open Quickfix List" })
map("n", "<leader>cc", "<Cmd>cclose<CR>", { desc = "Close Quickfix List" })
