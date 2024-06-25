return {
  -- {
  --   "plugin/shorthand",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile", "BufWritePre", "CmdlineEnter",
  --   "InsertEnter", "VeryLazy", "VimEnter" },
  --   config = function()
  --     require("shorthand").setup()
  --    end
  -- },
  --
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
}
