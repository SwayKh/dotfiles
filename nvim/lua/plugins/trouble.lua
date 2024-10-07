return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  cmd = "Trouble",
  config = function()
    local trouble = require("trouble")
    trouble.setup({
      auto_jump = true, -- auto jump to the item when there's only one
      focus = true, -- Focus the window when opened
      auto_preview = true, -- automatically open preview when on an item
      auto_refresh = true, -- auto refresh when open
      preview = {
        type = "main",
        -- Set to false, if you want the preview to always be a real loaded buffer.
        scratch = true,
      },
      win = {
        border = "none",
        size = 0.38, -- This weird size makes sense with the resize autocmd
      },
      modes = {
        symbols = {
          win = { position = "right" },
          focus = true,
        },
        diagnostics = {
          win = { position = "right" },
          focus = true,
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
    vim.keymap.set("n", "[q", function(self)
      if require("trouble").is_open() then
        trouble.prev(self, { skip_groups = true, jump = true, focus = false })
      else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end, { silent = true, desc = "Previous Trouble/Quickfix Item" })
    vim.keymap.set("n", "]q", function(self)
      if require("trouble").is_open() then
        trouble.next(self, { skip_groups = true, jump = true, focus = false })
      else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end, { silent = true, desc = "Next Trouble/Quickfix Item" })
  end,
}
