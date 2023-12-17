return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local oil = require("oil")
    oil.setup({
      skip_confirm_for_simple_edits = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      preview = {
        border = "rounded",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<Tab>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
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
    -- oil.select({ preview = true })

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "OilEnter",
    --   callback = vim.schedule_wrap(function(args)
    --     if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
    --       oil.select({ preview = true })
    --     end
    --   end),
    -- })
  end,
}
