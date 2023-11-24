return {
  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {--[[ things you want to change go here]]
    },

    vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "[T]oggleTerm [F]loating" }),
    vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { desc = "[T]oggleTerm [H]orizontal" }),
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "[T]oggleTerm [V]ertical" }),
  },
}
