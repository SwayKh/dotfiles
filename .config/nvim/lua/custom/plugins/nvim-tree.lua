return {
  {"kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        open_on_tab = true,
        disable_netrw = true,
        hijack_netrw = true,
        update_cwd = true,
        hijack_cursor = true,
        view = {
          width = 30,
        },
        filters = {
          dotfiles = true,
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          root_folder_modifier = ':t',
          icons = {
            glyphs = {
              default = '',
              symlink = '',
              bookmark = '◉',
              -- git = {
              --   unstaged = '',
              --   staged = '',
              --   unmerged = '',
              --   renamed = '',
              --   deleted = '',
              --   untracked = '',
              --   ignored = '',
              -- },
              folder = {
                default = '',
                open = '',
                symlink = '',
              },
            },
            show = {
              git = true,
              file = true,
              folder = true,
              folder_arrow = false,
            },
          },
          indent_markers = {
            enable = true,
          },
        },
      })
    end,
  },
}
