return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",

  config = function()
    -- require("mini.starter").setup() -- Won't work because mini is lazy loaded
    require("mini.extra").setup()
    require("mini.pairs").setup()
    require("mini.tabline").setup()
    require("mini.notify").setup()

    require("mini.git").setup()
    require("mini.icons").setup()
    require("mini.notify").setup()
    require("mini.align").setup()

    require("mini.files").setup()
    require("mini.jump").setup({ mappings = { repeat_jump = "," } })
    require("mini.jump2d").setup({ view = { dim = true } })

    vim.keymap.set("n", "-", function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      MiniFiles.open(path)
      MiniFiles.reveal_cwd()
    end, { desc = "Open Mini Files" })

    -- vim.keymap.set("n", "<C-s>", function()
    --   if vim.api.nvim_buf_get_name(0):match("minifiles") then
    --     print("That's the correct file type")
    --   end
    --
    --   if vim.bo.filetype == "minifiles" then
    --     MiniFiles.synchronize()
    --   else
    --     vim.cmd("wall")
    --   end
    -- end, { desc = "Save changes with C-s in MiniFiles" })

    -- Mocks nvim-web-devicons, for plugins that don't support Mini.Icons
    MiniIcons.mock_nvim_web_devicons()

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

        B = require("mini.extra").gen_ai_spec.buffer(),
        D = require("mini.extra").gen_ai_spec.diagnostic(),
        I = require("mini.extra").gen_ai_spec.indent(),
        L = require("mini.extra").gen_ai_spec.line(),
        N = require("mini.extra").gen_ai_spec.number(),
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

    require("mini.hipatterns").setup({
      highlighters = {
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        todo = require("mini.extra").gen_highlighter.words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
        hack = require("mini.extra").gen_highlighter.words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
        note = require("mini.extra").gen_highlighter.words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
        fixme = require("mini.extra").gen_highlighter.words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      },
    })

    require("mini.diff").setup({
      view = {
        style = "sign",
        signs = { add = "+", change = "~", delete = "-" },
      },
    })

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

    -- Split or Join arguments inside brackets/braces/parenthesis
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "gS",
        split = "",
        join = "",
      },
    })

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
      symbol = "╎", --  ╎ │
      draw = {
        delay = 50,
        animation = require("mini.indentscope").gen_animation.none(), --<function: implements constant 20ms between steps>,
      },
      options = {
        try_as_border = true,
      },
    })

    local miniclue = require("mini.clue")
    miniclue.setup({
      window = {
        delay = 300,
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        config = {
          width = "auto",
          border = "none",
        },
      },
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })

    require("mini.statusline").setup({
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          -- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 200 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local macro = vim.g.macro_recording

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
  end,
}
