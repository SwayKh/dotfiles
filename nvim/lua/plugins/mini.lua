local later = MiniDeps.later

require("mini.icons").setup()
require("mini.tabline").setup()

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

later(function()
  require("mini.align").setup()
  require("mini.bracketed").setup()
  require("mini.extra").setup()
  require("mini.git").setup()
  require("mini.pairs").setup()
  require("mini.splitjoin").setup()
  require("mini.surround").setup()

  require("mini.jump2d").setup({
    view = {
      dim = true,
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

  require("mini.files").setup({
    mappings = {
      go_in_plus = "<cr>",
      synchronize = "<c-s>",
    },
    windows = {
      preview = true,
      width_focus = 40,
      width_preview = 80,
    },
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
      local win_id = args.data.win_id

      -- Customize window-local settings
      local config = vim.api.nvim_win_get_config(win_id)
      config.border = vim.g.border_style
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })

  require("mini.pick").setup({
    options = {
      content_from_bottom = true,
    },
    window = {
      prompt_prefix = " ❯ ",
      config = {
        border = vim.g.border_style,
      },
    },
    mappings = {
      to_quickfix = {
        char = "<c-q>",
        func = function()
          local items = MiniPick.get_picker_items() or {}
          MiniPick.default_choose_marked(items)
          MiniPick.stop()
        end,
      },
      all_to_quickfix = {
        char = "<A-q>",
        func = function()
          local matched_items = MiniPick.get_picker_matches().all or {}
          MiniPick.default_choose_marked(matched_items)
          MiniPick.stop()
        end,
      },
    },
  })

  vim.keymap.set("n", "<leader>sf", function()
    MiniPick.builtin.files()
  end, { desc = "[S]earch [F]iles" })

  vim.keymap.set("n", "<leader>s?", function()
    MiniExtra.pickers.oldfiles()
  end, { desc = "[S]earch [O]ldfiles" })

  vim.keymap.set("n", "<leader>gf", function()
    MiniExtra.pickers.git_files()
  end, { desc = "[S]earch [G]it files" })

  vim.keymap.set("n", "<leader>gw", function()
    MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
  end, { desc = "[G]rep current [W]ord" })

  vim.keymap.set("n", "<leader>sw", function()
    MiniPick.builtin.grep()
  end, { desc = "[S]earch [W]ord" })

  vim.keymap.set("n", "<leader>sg", function()
    MiniPick.builtin.grep_live()
  end, { desc = "[S]earch by [G]rep" })

  vim.keymap.set("n", "<leader>sr", function()
    MiniPick.builtin.resume()
  end, { desc = "[S]earch [R]esume" })

  vim.keymap.set("n", "<leader>sk", function()
    MiniExtra.pickers.keymaps()
  end, { desc = "[S]earch [K]eymaps" })

  vim.keymap.set("n", "<leader>sc", function()
    MiniExtra.pickers.commands()
  end, { desc = "[S]earch [C]ommands" })

  vim.keymap.set("n", "<leader>sd", function()
    MiniExtra.pickers.diagnostic()
  end, { desc = "[S]earch [D]iagnostics" })

  vim.keymap.set("n", "<leader><leader>", function()
    MiniPick.builtin.buffers()
  end, { desc = "[ ] Find existing buffers" })

  vim.keymap.set("n", "<leader>sh", function()
    MiniPick.builtin.help({}, {
      source = {
        name = " Help  ",
      },
      options = {
        content_from_bottom = false,
      },
      window = {
        config = {
          height = math.floor(0.35 * vim.o.lines),
          width = vim.api.nvim_win_get_width(0),
        },
      },
    })
  end, { desc = "[S]earch [H]elp" })

  vim.keymap.set("n", "<leader>s/", function()
    MiniExtra.pickers.buf_lines({ scope = "current", preserve_order = true }, {
      source = {
        name = " Grep Buffer ",
      },
      options = {
        content_from_bottom = false,
      },
      window = {
        config = {
          height = math.floor(0.35 * vim.o.lines),
          width = vim.api.nvim_win_get_width(0),
        },
      },
    })
  end, { desc = "[S]earch [/] in current buffer" })

  vim.keymap.set("n", "<leader>sn", function()
    MiniPick.builtin.files({}, {
      source = {
        name = "Neovim config",
        cwd = vim.fn.stdpath("config"),
      },
    })
  end, { desc = "[S]earch [N]vim config" })

  vim.keymap.set("n", "<leader>s.", function()
    MiniPick.builtin.files({}, {
      source = {
        name = "Dotfiles",
        cwd = os.getenv("HOME") .. "/dotfiles",
      },
    })
  end, { desc = "[S]earch [N]vim config" })

  vim.keymap.set("n", "<leader>st", function()
    local colorscheme = MiniPick.start({
      source = {
        name = " Colorscheme ",
        items = vim.fn.getcompletion("", "color"),
      },
    })
    if colorscheme ~= nil then
      vim.cmd("colorscheme " .. colorscheme)
    end
  end, { desc = "[S]earch [T]hemes/Colorscheme" })

  vim.keymap.set("n", "-", function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
    MiniFiles.open(path)
    MiniFiles.reveal_cwd()
  end, { desc = "Open Mini Files" })

  vim.keymap.set(
    { "n", "x" },
    "<leader>gs",
    "<Cmd>lua MiniGit.show_at_cursor()<CR>",
    { silent = true, desc = "Show Git Status" }
  )

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
      u = require("mini.ai").gen_spec.function_call(), -- u for "Usage"
      U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
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

  local miniclue = require("mini.clue")
  miniclue.setup({
    window = {
      delay = 300,
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
      config = {
        width = "auto",
        border = vim.g.border_style,
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

      -- Bracketed Keybinds
      { mode = "n", keys = "]" },
      { mode = "n", keys = "[" },

      -- Surround Keybinds
      { mode = "n", keys = "s" },
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

  -- Mocks nvim-web-devicons, for plugins that don't support Mini.Icons
  MiniIcons.mock_nvim_web_devicons()
  vim.ui.select = MiniPick.ui_select
end)

return {}
