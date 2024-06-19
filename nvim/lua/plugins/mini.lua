return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",

  config = function()
    require("mini.ai").setup({
      mappings = {
        around = "a",
        inside = "i",

        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 500,
      custom_textobjects = {
        o = require("mini.ai").gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        d = { "%f[%d]%d+" }, -- digits
        e = { -- Word with case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        g = function() -- Whole buffer, similar to `gg` and 'G' motion
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
        u = require("mini.ai").gen_spec.function_call(), -- u for "Usage"
        U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    })

    require("mini.pairs").setup({
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
      },
    })

    -- Tabline plugin
    require("mini.tabline").setup()
    require("mini.notify").setup()
    require("mini.git").setup()

    -- require("mini.animate").setup({
    --   cursor = {
    --     enable = false,
    --   },
    -- })

    require("mini.bracketed").setup({
      buffer = { suffix = "b", options = {} },
      comment = { suffix = "c", options = {} },
      conflict = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file = { suffix = "f", options = {} },
      indent = { suffix = "i", options = {} },
      jump = { suffix = "j", options = {} },
      location = { suffix = "l", options = {} },
      oldfile = { suffix = "o", options = {} },
      quickfix = { suffix = "q", options = {} },
      treesitter = { suffix = "t", options = {} },
      undo = { suffix = "u", options = {} },
      window = { suffix = "w", options = {} },
      yank = { suffix = "y", options = {} },
    })

    -- Comment lines in visual or normal mode
    -- Nvim 10.0 has commenting builtin with these keybinds
    -- require("mini.comment").setup({
    --   mappings = {
    --     comment = "gc",
    --     comment_line = "gcc",
    --     comment_visual = "gc",
    --     textobject = "gc",
    --   },
    -- })

    -- Split or Join arguments inside brackets/braces/parenthesis
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "gS",
        split = "",
        join = "",
      },
    })
    -- require("mini.starter").setup() -- Won't work because mini is lazy loaded

    require("mini.surround").setup({
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    })

    require("mini.indentscope").setup({
      symbol = "│", --  ╎ │
      draw = {
        delay = 50,
        animation = require("mini.indentscope").gen_animation.none(), --<function: implements constant 20ms between steps>,
      },
      options = {
        try_as_border = true,
      },
    })

    require("mini.statusline").setup({
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local check_macro_recording = function()
            if vim.fn.reg_recording() ~= "" then
              return "Recording @" .. vim.fn.reg_recording()
            else
              return ""
            end
          end

          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          -- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 200 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local macro = check_macro_recording()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFilename", strings = { macro } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    })

    -- require("mini.clue").setup({
    --   triggers = {
    --     -- Leader triggers
    --     { mode = "n", keys = "<Leader>" },
    --     { mode = "x", keys = "<Leader>" },
    --
    --     -- Built-in completion
    --     { mode = "i", keys = "<C-x>" },
    --
    --     -- `g` key
    --     { mode = "n", keys = "g" },
    --     { mode = "x", keys = "g" },
    --
    --     -- Marks
    --     { mode = "n", keys = "'" },
    --     { mode = "n", keys = "`" },
    --     { mode = "x", keys = "'" },
    --     { mode = "x", keys = "`" },
    --
    --     -- Registers
    --     { mode = "n", keys = '"' },
    --     { mode = "x", keys = '"' },
    --     { mode = "i", keys = "<C-r>" },
    --     { mode = "c", keys = "<C-r>" },
    --
    --     -- Window commands
    --     { mode = "n", keys = "<C-w>" },
    --
    --     -- `z` key
    --     { mode = "n", keys = "z" },
    --     { mode = "x", keys = "z" },
    --   },
    --
    --   clues = {
    --     -- Enhance this by adding descriptions for <Leader> mapping groups
    --     require("mini.clue").gen_clues.builtin_completion(),
    --     require("mini.clue").gen_clues.g(),
    --     require("mini.clue").gen_clues.marks(),
    --     require("mini.clue").gen_clues.registers(),
    --     require("mini.clue").gen_clues.windows(),
    --     require("mini.clue").gen_clues.z(),
    --   },
    -- })
  end,
}
