return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
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
      pickers = {
        colorscheme = {
          enable_preview = true,
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
    vim.keymap.set("n", "<leader>lr", function(opts)
      opts = opts or {}
      pickers
        .new(opts, {
          prompt_title = "Plugins",
          finder = finders.new_table({
            results = require("config.utils").pluginNames(),
          }),
          sorter = conf.generic_sorter(opts),

          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              vim.cmd("Lazy reload " .. selection[1])
            end)
            return true
          end,
        })
        :find()
    end, { desc = "[L]azy [R]eload plugin of choice" })

    vim.keymap.set("n", "<leader>sc", ":Telescope colorscheme<CR>", { desc = "Telescope [S]how [C]olorscheme" })
    vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = "Telescope [S]how [K]eymaps" })

    telescope.load_extension("fzf")
  end,
}
