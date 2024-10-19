return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>tD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>tL", "<cmd>Trouble lsp toggle<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>ds", "<cmd>Trouble symbols toggle<cr>", desc = "Document Symbols (Trouble)" },
    {
      "[q",
      function(self)
        if require("trouble").is_open() then
          trouble.prev(self, { skip_groups = true, jump = true, focus = false })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
    {
      "]q",
      function(self)
        if require("trouble").is_open() then
          trouble.next(self, { skip_groups = true, jump = true, focus = false })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
  },
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
  end,
}
