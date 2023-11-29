return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "b", api.tree.change_root_to_node, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      end
      require("nvim-tree").setup()

      require("nvim-tree").setup({
        on_attach = my_on_attach,
        view = {
          width = 30,
          number = true,
          relativenumber = true,
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
            resize_window = true,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = { ".git", "target", "build" },
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          root_folder_modifier = ":t",
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },

            glyphs = {
              default = "󰈚",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      })

      local api = require("nvim-tree.api")
      local Event = api.events.Event
      api.events.subscribe(Event.TreeOpen, function()
        api.tree.expand_all()
      end)
    end,
  },
}
