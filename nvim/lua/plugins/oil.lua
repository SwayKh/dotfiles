return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  -- Optional dependencies
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      preview = {
        border = "rounded",
        update_on_cursor_moved = true,
      },
      win_options = {
        signcolumn = "number",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<Tab>"] = "actions.preview",
        ["<Esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    })

    vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { silent = true, desc = "Open Parent Directory" })
    vim.keymap.set("n", "<leader>-", "<Cmd>Oil --float<CR>", { silent = true, desc = "Open Oil in floating mode" })

    -- Toggle preview on enter and move cursor to files buffer
    -- This breaks floating mode
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.open_preview()
          vim.cmd("wincmd L")
        end
      end),
    })
  end,
}
