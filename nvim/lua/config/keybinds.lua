-- [[ Basic Keymaps ]]

local map = vim.keymap.set

-- My Keybinds
-- Plugin specific keymaps are in the plugin configs
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("i", "jj", "<Esc>")
map("n", "<leader>.", ":source $MYVIMRC<CR>", { silent = true, desc = "Source nvim config, and reload all plugins" })
map("n", "<leader>,", "@@", { silent = true, desc = "Run last macro, @@ is hard to do" })

map("n", "<leader>y", ":%y+<CR>", { silent = true, desc = "Copy whole file" })
map("x", "<leader>p", '"_dP', { silent = true, desc = "Don't replace paste register when replacing something" })

map("n", "qq", ":q<CR>", { silent = true, desc = "[Q]uit" })
map("n", "<leader>bd", ":bd<CR>", { silent = true, desc = "Run [B]buffer [D]elete" })
map("n", "<leader>q", "<ESC>:wqa!<CR>", { silent = true, desc = "Save all files [Q]uit" })
map({ "n", "i", "v" }, "<C-s>", "<ESC>:w!<CR>", { silent = true, desc = "[S]ave file" })

map("n", "<leader>lr", ":Lazy reload", { desc = "[L]azy [R]eload plugin of choice" })
map("n", "-", ":Oil --float<CR>", { silent = true, desc = "Open Oil in floating mode" })

-- Can't use K, needed for documentation
map({ "n", "v" }, "H", "_^", { desc = "Move to the beginning of the line" })
map({ "n", "v" }, "L", "$", { desc = "Move to the end of the line" })
map(
  { "n", "v" },
  "M",
  ":call cursor(0, virtcol('$')/2)<CR>",
  { silent = true, desc = "Move to the middle of the line" }
)

map("n", "<C-u>", "<C-u>zz", { desc = "Better half up scroll", remap = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Better half down scroll", remap = true })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("i", "<C-j>", "<Down>", { desc = "Move Down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move Up in insert mode" })
map("i", "<C-h>", "<Left>", { desc = "Move Left in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move Right in insert mode" })

map("n", "<C-j>", "<C-w>j", { desc = "Move Between splits with HJKL" })
map("n", "<C-k>", "<C-w>k", { desc = "Move Between splits with HJKL" })
map("n", "<C-h>", "<C-w>h", { desc = "Move Between splits with HJKL" })
map("n", "<C-l>", "<C-w>l", { desc = "Move Between splits with HJKL" })

-- Split Resize
map("n", "<leader>v", ":vsplit<CR>", { desc = "Split [V]ertically" })
map("n", "<leader>s", ":split<CR>", { desc = "[S]plit Horizontally (Default behaviour)" })
map("n", "<C-S-Left>", ":vertical resize +3<CR>") -- Control+Left resizes vertical split +
map("n", "<C-S-Right>", ":vertical resize -3<CR>") -- Control+Right resizes vertical split -

map("n", "<C-S-h>", "<C-w>>") -- resize window to left
map("n", "<C-S-l>", "<C-w><") -- resize window to right
map("n", "<C-S-k>", "<C-w>+") -- resize window to up
map("n", "<C-S-j>", "<C-w>-") -- resize window to down

-- Autocomplete brackets and quotes
-- Feels annoying somehow, autopair plugin is better
-- map("i", "'", "''<left>")
-- map("i", '"', '""<left>')
-- map("i", "(", "()<left>")
-- map("i", "[", "[]<left>")
-- map("i", "{", "{}<left>")
-- map("i", "{;", "{};<left><left>")
-- map("i", "/*", "/**/<left><left>")

vim.cmd("cnoreabbrev Q  q")
vim.cmd("cnoreabbrev q1  q!")
vim.cmd("cnoreabbrev Q1  q!")
vim.cmd("cnoreabbrev Qa1 qa!")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
