return {
  "ThePrimeagen/harpoon",
  -- lazy = true,
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

    vim.keymap.set("n", "<leader>h", function()
      ui.toggle_quick_menu()
    end)
    vim.keymap.set("n", "<leader>a", function()
      mark.add_file()
    end)
    require("telescope").load_extension("harpoon")
  end,
}
