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
  -- { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
