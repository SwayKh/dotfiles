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
      oil.select({ preview = true }),
    })

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
