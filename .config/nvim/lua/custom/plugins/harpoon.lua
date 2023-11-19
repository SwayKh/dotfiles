return {
  "ThePrimeagen/harpoon",
  lazy = true,
  config = function()
    local harpoon = require("harpoon")
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
    require("telescope").load_extension("harpoon")
  end,
}
