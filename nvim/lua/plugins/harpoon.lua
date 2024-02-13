return {
  "ThePrimeagen/harpoon",
  lazy = true,
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
    vim.keymap.set("n", "<leader>h.", mark.add_file, { silent = true, desc = "Add file to harpoon" })
    vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { silent = true, desc = "Show regular Harpoon quick menu" })

    -- require("telescope").load_extension("harpoon")
  end,
}
