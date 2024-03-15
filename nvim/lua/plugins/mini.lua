return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,

  lazy = true,
  event = "VeryLazy",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.pairs").setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    --  [s/S] keybinds are used for flash, will figure it out
    -- require("mini.surround").setup()

    -- require("mini.starter").setup()
    -- require("mini.indentscope").setup()

    -- require("mini.hipatterns").setup({
    --   highlighters = {
    --     hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
    --   },
    -- })

    require("mini.comment").setup({
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
    })

    local statusline = require("mini.statusline")
    statusline.setup()

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return ""
    end
  end,
}
