return {
  "ThePrimeagen/harpoon",
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

    vim.keymap.set("n", "<leader>h", ":Telescope harpoon marks<CR>", { desc = "Show harpoon quick menu" })
    vim.keymap.set("n", "<leader>.", mark.add_file, { desc = "Add file to harpoon" })
    require("telescope").load_extension("harpoon")
  end,
}
