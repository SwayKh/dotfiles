-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help map()`

local map = vim.keymap.set

-- My Keybinds
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("i", "jj", "<Esc>")

map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "-", ":Oil <CR>")

-- Plugin specific keymaps are in the plugin configs

map("i", "<C-j>", "<Down>", { desc = "Move Down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move Up in insert mode" })
map("i", "<C-h>", "<Left>", { desc = "Move Left in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move Right in insert mode" })

map("n", "<C-j>", "<C-w>j", { desc = "Move Between splits with HJKL" })
map("n", "<C-k>", "<C-w>k", { desc = "Move Between splits with HJKL" })
map("n", "<C-h>", "<C-w>h", { desc = "Move Between splits with HJKL" })
map("n", "<C-l>", "<C-w>l", { desc = "Move Between splits with HJKL" })

map({ "n", "i", "v" }, "<C-s>", "<ESC>:w<CR>", { desc = "[S]ave file" })
map({ "n", "v" }, "qq", "<ESC>:bd<CR>", { desc = "[Q]uit, Actually runs :bd buffer delete" })
map({ "n", "v" }, "<leader>q", "<ESC>:wqa!<CR>", { desc = "Save all files [Q]uit" })

map("n", "<leader>v", ":vsplit<CR>", { desc = "Split [V]ertically" })
map("n", "<leader>s", ":split<CR>", { desc = "[S]plit Horizontally (Default behaviour)" })

map("n", "<C-d>", "<C-d>zz", { desc = "Better half down scroll", remap = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Better half down scroll", remap = true })
map("x", "<leader>p", '"_dP', { desc = "Don't replace paste register when replacing something" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- Don't need these right now
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
