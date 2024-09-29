return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  cmd = "Trouble",
  config = function()
    require("trouble").setup({
      auto_jump = true, -- auto jump to the item when there's only one
      focus = true, -- Focus the window when opened
      win = {
        border = "none",
        size = 0.30,
      },
      modes = {
        symbols = {
          win = { position = "bottom" },
          focus = false,
        },
      },
    })

    vim.keymap.set(
      "n",
      "<leader>td",
      "<cmd>Trouble diagnostics toggle<cr>",
      { silent = true, desc = "Diagnostics (Trouble)" }
    )
    vim.keymap.set(
      "n",
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      { silent = true, desc = "Buffer Diagnostics (Trouble)" }
    )
    vim.keymap.set(
      "n",
      "<leader>tL",
      "<cmd>Trouble lsp toggle<cr>",
      { silent = true, desc = "LSP Definitions / references / ... (Trouble)" }
    )
    vim.keymap.set(
      "n",
      "<leader>tl",
      "<cmd>Trouble loclist toggle<cr>",
      { silent = true, desc = "Location List (Trouble)" }
    )
    vim.keymap.set(
      "n",
      "<leader>tq",
      "<cmd>Trouble qflist toggle<cr>",
      { silent = true, desc = "Quickfix List (Trouble)" }
    )
    vim.keymap.set(
      "n",
      "<leader>ds",
      "<cmd>Trouble symbols toggle<cr>",
      { silent = true, desc = "Document Symbols (Trouble)" }
    )
  end,
}
