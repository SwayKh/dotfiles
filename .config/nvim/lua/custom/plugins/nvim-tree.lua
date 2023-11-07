return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      local function my_on_attach(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.tree.expand_all()

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', 'b', api.tree.change_root_to_node, opts 'Up')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
      end
      require('nvim-tree').setup()

      require('nvim-tree').setup {
        on_attach = my_on_attach,
        sort_by = 'case_sensitive',
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
          expand_all = {
            max_folder_discovery = 500,
            exclude = { '.git', 'target', 'build' },
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          root_folder_modifier = ':t',
          icons = {
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
      }
    end,
  },
}
