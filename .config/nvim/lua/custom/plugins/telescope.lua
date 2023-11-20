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
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>?", ":Telescope oldfiles<CR>", { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", ":Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
        winblend = 10,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>gf", ":Telescope git_files<CR>", { desc = "Search [G]it [F]iles" }) --git_files
    vim.keymap.set("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "[S]earch [F]iles" }) --find_files
    vim.keymap.set("n", "<leader>sh", ":Telescope help_tags<CR>", { desc = "[S]earch [H]elp" }) --help_tags
    vim.keymap.set("n", "<leader>sw", ":Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" }) --grep_string
    vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" }) --live_grep
    vim.keymap.set("n", "<leader>sd", ":Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" }) --diagnostics
    vim.keymap.set("n", "<leader>sr", ":Telescope resume<CR>", { desc = "[S]earch [R]esume" }) --resume

    telescope.load_extension("fzf")
  end,
}
