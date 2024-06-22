return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  event = "VeryLazy",
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      sticky = true,
      padding = true,
      toggler = {
        line = "gcc",
      },
      opleader = {
        line = "gc",
      },
      mappings = {
        basic = true,
        extra = true,
      },
    })
  end,
}
