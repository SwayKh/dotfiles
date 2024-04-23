return {
  "stevearc/oil.nvim",
  opts = {},
  lazy = true,
  event = "VeryLazy",
  -- Optional dependencies
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "SirZenith/oil-vcs-status",
  },

  config = function()
    -- local vcs = require("oil-vcs-status")
    -- local status_const = require("oil-vcs-status.constant.status")
    -- local StatusType = status_const.StatusType

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

    vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", { silent = true, desc = "Open Oil in floating mode" })
    -- vcs.setup({
    --   status_symbol = {
    --     [StatusType.Added] = "",
    --     [StatusType.Copied] = "󰆏",
    --     [StatusType.Deleted] = "",
    --     [StatusType.Ignored] = "",
    --     [StatusType.Modified] = "",
    --     [StatusType.Renamed] = "",
    --     [StatusType.TypeChanged] = "󰉺",
    --     [StatusType.Unmodified] = " ",
    --     [StatusType.Unmerged] = "",
    --     [StatusType.Untracked] = "",
    --     [StatusType.External] = "",
    --
    --     [StatusType.UpstreamAdded] = "󰈞",
    --     [StatusType.UpstreamCopied] = "󰈢",
    --     [StatusType.UpstreamDeleted] = "",
    --     [StatusType.UpstreamIgnored] = " ",
    --     [StatusType.UpstreamModified] = "󰏫",
    --     [StatusType.UpstreamRenamed] = "",
    --     [StatusType.UpstreamTypeChanged] = "󱧶",
    --     [StatusType.UpstreamUnmodified] = " ",
    --     [StatusType.UpstreamUnmerged] = "",
    --     [StatusType.UpstreamUntracked] = " ",
    --     [StatusType.UpstreamExternal] = "",
    --   },
    -- })
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
