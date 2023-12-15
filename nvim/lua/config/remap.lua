-- [[ Basic Keymaps ]]

local map = vim.keymap.set

-- My Keybinds
-- Plugin specific keymaps are in the plugin configs
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("i", "jj", "<Esc>")
map("n", "-", ":Oil <CR>")
map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<leader>y", ":%y+<CR>", { desc = "Copy whole file" })
map("x", "<leader>p", '"_dP', { desc = "Don't replace paste register when replacing something" })

map({ "n", "i", "v" }, "<C-s>", "<ESC>:w!<CR>", { desc = "[S]ave file" })
map({ "n", "v" }, "qq", ":q<CR>", { desc = "[Q]uit, Actually runs :bd buffer delete" })
map({ "n", "v" }, "<leader>q", "<ESC>:wqa!<CR>", { desc = "Save all files [Q]uit" })
map("n", "<C-u>", "<C-u>zz", { desc = "Better half down scroll", remap = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Better half down scroll", remap = true })

-- Can't use K, needed for documentation
-- map({ "n", "v" }, "J", "<C-d>zz", { desc = "Move Down smoothly" })
-- map({ "n", "v" }, "K", "<C-u>zz", { desc = "Move Up smoothly" })
map({ "n", "v" }, "H", "_^", { desc = "Move to the beginning of the line" })
map({ "n", "v" }, "L", "$", { desc = "Move to the end of the line" })
map({ "n", "v" }, "M", "gm", { desc = "Move to the middle of the line" })

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

map("n", "<C-S-h>", "<C-w><") -- resize window to left
map("n", "<C-S-l>", "<C-w>>") -- resize window to right
map("n", "<C-S-k>", "<C-w>+") -- resize window to up
map("n", "<C-S-j>", "<C-w>-") -- resize window to down

-- Autocomplete brackets and quotes
map("i", "'", "''<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")

-- document existing key chains
require("which-key").register({
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})
