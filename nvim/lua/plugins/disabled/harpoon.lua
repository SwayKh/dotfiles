return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    harpoon.setup({
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
        mark_branch = false,
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      },
    })

    -- vim.keymap.set("n", "<leader>h", ":Telescope harpoon marks<CR>", { desc = "Show harpoon quick menu" })
    vim.keymap.set("n", "<leader>ha", mark.add_file, { silent = true, desc = "Add file to harpoon" })
    vim.keymap.set("n", "<leader>hr", mark.remove_file, { silent = true, desc = "Remove file from harpoon" })
    vim.keymap.set("n", "<leader>ho", ui.toggle_quick_menu, { silent = true, desc = "Show regular Harpoon quick menu" })
    vim.keymap.set("n", "<leader>hc", ui.clear_all, { silent = true, desc = "Clear all files from harpoon" })

    vim.keymap.set("n", "<leader>1", ui.nav_file(1), { silent = true, desc = "Navigate to file 1 in harpoon menu" })
    vim.keymap.set("n", "<leader>2", ui.nav_file(2), { silent = true, desc = "Navigate to file 2 in harpoon menu" })
    vim.keymap.set("n", "<leader>3", ui.nav_file(3), { silent = true, desc = "Navigate to file 3 in harpoon menu" })
    vim.keymap.set("n", "<leader>4", ui.nav_file(4), { silent = true, desc = "Navigate to file 4 in harpoon menu" })
    vim.keymap.set("n", "<leader>5", ui.nav_file(4), { silent = true, desc = "Navigate to file 5 in harpoon menu" })
  end,
}
