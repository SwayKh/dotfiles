-- [[ Basic Keymaps ]]

local map = vim.keymap.set

-- Misc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>m.", "@@", { silent = true, desc = "Run last [M]acro, @@ is awkward" })
map("n", "<leader>f", "<Cmd>Lexplore!<CR>", { silent = true, desc = "Open netrw on right side" }) -- Try Vex or Vex! to open in a split

map("n", "<leader>X", "<Cmd>source %<CR>", { silent = true, desc = "Source current file" })
map("n", "<space>x", "<Cmd>.lua<CR>", { desc = "Execute selected lua lines" })
map("v", "<space>x", ":lua<CR>", { desc = "Execute selected lua lines" })

-- Reload all lua files under neovim config
-- map("n", "<leader>.", "<Cmd>source ~/.config/nvim/init.lua<CR>", { silent = true, desc = "Source nvim config" })
map("n", "<leader>rc", function()
  require("config.utils").reloadConfig()
end, { silent = true, desc = "Source nvim config" })

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

-- Scroll keybinds
map({ "n", "v" }, "<M-j>", "5j", { desc = "Scroll 5 lines down" })
map({ "n", "v" }, "<M-k>", "5k", { desc = "Scroll 5 lines up" })

-- Split keybinds, Need to figure out a better system
map("n", "<leader>V", "<Cmd>vsplit<CR>", { desc = "Split [V]ertically" })
map("n", "<leader>H", "<Cmd>split<CR>", { desc = "Split [H]orizontally" })

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

-- Buffer keybinds
-- map("n", "<leader>bd", "<Cmd>bdelete<CR>", { silent = true, desc = "Run [B]buffer [D]elete" })
map("n", "<leader>bn", "<Cmd>bnext<CR>", { silent = true, desc = "Run [B]buffer [N]ext" })
map("n", "<leader>bp", "<Cmd>bprevious<CR>", { silent = true, desc = "Run [B]buffer [P]revious" })

-- Open Lazy/Mason UIs and reload plugins
-- map("n", "<leader>ol", "<Cmd>Lazy<CR>", { silent = true, desc = "Open [L]azy" })
map("n", "<leader>om", "<Cmd>Mason<CR>", { silent = true, desc = "Open [M]ason" })

-- Quickfix list keybinds
map("n", "<leader>cn", "<Cmd>cnext<CR>", { desc = "Go to next item in Quickfix list" })
map("n", "<leader>cp", "<Cmd>cprev<CR>", { desc = "Go to previous item in Quickfix list" })
map("n", "<leader>co", "<Cmd>copen<CR>", { desc = "Open Quickfix List" })
map("n", "<leader>cc", "<Cmd>cclose<CR>", { desc = "Close Quickfix List" })

-- Remap common typos when saving and closing files
vim.cmd("cnoreabbrev Q  q")
vim.cmd("cnoreabbrev q1  q!")
vim.cmd("cnoreabbrev Q1  q!")
vim.cmd("cnoreabbrev Qa1 qa!")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
