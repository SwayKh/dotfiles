return {
  "supermaven-inc/supermaven-nvim",
  lazy = true,
  event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
  -- event = "InsertEnter",
  -- event = "VeryLazy",
  config = function()
    require("supermaven-nvim").setup({
      disable_inline_completion = true, -- disables inline completion for use with cmp
      disable_keymaps = true, -- disables built in keymaps for more manual control
    })
  end,
}
