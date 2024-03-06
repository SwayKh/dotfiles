return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  lazy = true,
  event = "VeryLazy",
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      sticky = true,
      padding = true,
      toggler = {
        line = "<M-/>",
      },
      opleader = {
        line = "<M-/>",
      },
      mappings = {
        basic = true,
        extra = true,
      },
    })
  end,
}
