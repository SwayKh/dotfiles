local map = vim.keymap.set
local opts = { noremap = true, silent = true }
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  -- Barbar.nvim keymaps
  -- Move to previous/next
  map("n", "<A-,>", ":BufferPrevious<CR>", opts),
  map("n", "<A-;>", ":BufferNext<CR>", opts),

  map("n", "<A-<>", ":BufferMovePrevious<CR>", opts),
  map("n", "<A->>", ":BufferMoveNext<CR>", opts),

  map("n", "<A-1>", ":BufferGoto 1<CR>", opts),
  map("n", "<A-2>", ":BufferGoto 2<CR>", opts),
  map("n", "<A-3>", ":BufferGoto 3<CR>", opts),
  map("n", "<A-4>", ":BufferGoto 4<CR>", opts),
  map("n", "<A-5>", ":BufferGoto 5<CR>", opts),
  map("n", "<A-6>", ":BufferGoto 6<CR>", opts),
  map("n", "<A-7>", ":BufferGoto 7<CR>", opts),
  map("n", "<A-8>", ":BufferGoto 8<CR>", opts),
  map("n", "<A-9>", ":BufferGoto 9<CR>", opts),
  map("n", "<A-0>", ":BufferLast<CR>", opts),
  -- Pin/unpin buffer
  map("n", "<A-p>", ":BufferPin<CR>", opts),
  -- Close buffer
  map("n", "<A-c>", ":BufferClose<CR>", opts),
  -- Wipeout buffer,
  --                 :BufferWipeout
  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight
  -- Magic buffer-picking mode
  -- map("n", "<C-p>", ":BufferPick<CR>", opts)
  -- Sort automatically by...
  map("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", opts),
  map("n", "<Space>bd", ":BufferOrderByDirectory<CR>", opts),
  map("n", "<Space>bl", ":BufferOrderByLanguage<CR>", opts),
  map("n", "<Space>bw", ":BufferOrderByWindowNumber<CR>", opts),
}
