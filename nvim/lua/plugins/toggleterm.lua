return {
  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {--[[ things you want to change go here]]
    },
    config = function()
      require("toggleterm").setup({
        size = 13,
        shade_filetypes = {},
        open_mapping = [[<c-\>]],
        shade_terminal = true,
        shading_factor = 1,
        start_in_insert = true,
        persist_size = true,
        direction = "horizontal",
        autochdir = true,
      })
      vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=float<CR>", { desc = "[T]oggleTerm [F]loating" })
      vim.keymap.set("n", "<leader>th", ":ToggleTerm <CR>", { desc = "[T]oggleTerm [H]orizontal" })
      vim.keymap.set(
        "n",
        "<leader>tv",
        ":ToggleTerm size=60 direction=vertical<CR>",
        { desc = "[T]oggleTerm [V]ertical" }
      )
    end,
  },
}
