local opts = { noremap = true, silent = true }
return {
  "romgrk/barbar.nvim",
  enabled = false,
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
    -- Barbar.nvim keyvim.keymap.sets
    vim.keymap.set("n", "<A-,>", ":BufferPrevious<CR>", opts),
    vim.keymap.set("n", "<A-;>", ":BufferNext<CR>", opts),

    vim.keymap.set("n", "<A-<>", ":BufferMovePrevious<CR>", opts),
    vim.keymap.set("n", "<A->>", ":BufferMoveNext<CR>", opts),

    vim.keymap.set("n", "<A-1>", ":BufferGoto 1<CR>", opts),
    vim.keymap.set("n", "<A-2>", ":BufferGoto 2<CR>", opts),
    vim.keymap.set("n", "<A-3>", ":BufferGoto 3<CR>", opts),
    vim.keymap.set("n", "<A-4>", ":BufferGoto 4<CR>", opts),
    vim.keymap.set("n", "<A-5>", ":BufferGoto 5<CR>", opts),
    vim.keymap.set("n", "<A-6>", ":BufferGoto 6<CR>", opts),
    vim.keymap.set("n", "<A-7>", ":BufferGoto 7<CR>", opts),
    vim.keymap.set("n", "<A-8>", ":BufferGoto 8<CR>", opts),
    vim.keymap.set("n", "<A-9>", ":BufferGoto 9<CR>", opts),
    vim.keymap.set("n", "<A-0>", ":BufferLast<CR>", opts),

    vim.keymap.set("n", "<A-p>", ":BufferPin<CR>", opts),
    vim.keymap.set("n", "<A-c>", ":BufferClose<CR>", opts),
    -- Wipeout buffer,
    --                 :BufferWipeout
    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight
    -- Magic buffer-picking mode
    -- vim.keymap.set("n", "<C-p>", ":BufferPick<CR>", opts)
    -- Sort automatically by...
    vim.keymap.set("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", opts),
    vim.keymap.set("n", "<Space>bd", ":BufferOrderByDirectory<CR>", opts),
    vim.keymap.set("n", "<Space>bl", ":BufferOrderByLanguage<CR>", opts),
    vim.keymap.set("n", "<Space>bw", ":BufferOrderByWindowNumber<CR>", opts),
  },
}
