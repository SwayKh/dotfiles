return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            -- ["<esc>"] = actions.close,
            -- ["<C-p>"] = actions.move_selection_previous,
            -- ["<C-n>"] = actions.move_selection_next,
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        -- path_display = { "truncate " },
      },
    })

    telescope.load_extension("fzf")
  end,
}
