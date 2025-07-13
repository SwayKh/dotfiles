require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.statusline").setup({
  use_icons = true,
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

local later = MiniDeps.later
later(function()
  require("mini.align").setup()
  require("mini.bracketed").setup()
  require("mini.comment").setup()
  require("mini.extra").setup()
  require("mini.git").setup()
  require("mini.jump").setup()
  require("mini.pairs").setup()
  require("mini.splitjoin").setup()
  require("mini.surround").setup()

  vim.keymap.set(
    { "n", "x" },
    "<leader>gs",
    "<Cmd>lua MiniGit.show_at_cursor()<CR>",
    { silent = true, desc = "Show Git Status" }
  )

  require("mini.jump2d").setup({
    spotter = require("mini.jump2d").builtin_opts.word_start.spotter,
    labels = "asdfghjkl",
    view = {
      dim = true,
      n_steps_ahead = 3,
    },
    allowed_windows = {
      current = true,
      not_current = false,
    },
  })

  require("mini.files").setup({
    mappings = {
      go_in_plus = "<cr>",
      synchronize = "<c-s>",
    },
    windows = {
      max_number = 3,
      preview = true,
      width_nofocus = math.floor((vim.o.columns - 5) * 0.25), -- 25% of screen minus border+padding
      width_focus = math.floor((vim.o.columns - 5) * 0.25), -- 25% of screen minus border+padding
      width_preview = math.floor((vim.o.columns - 3) * 0.5), -- 50% of screen minus border+padding,
    },
  })

  vim.keymap.set("n", "-", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
    MiniFiles.reveal_cwd()
  end, { desc = "Open Mini Files" })

  vim.api.nvim_create_autocmd("User", {
    pattern = { "MiniFilesWindowOpen", "MiniFilesWindowUpdate" },
    callback = function(args)
      local win_id = args.data.win_id

      -- Customize window-local settings
      local config = vim.api.nvim_win_get_config(win_id)
      config.border = vim.g.border_style
      -- Make window full height to make it look TUI File manager
      -- config.height = vim.o.lines
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })

  local win_config = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
      anchor = "NW",
      height = height,
      width = width,
      row = math.floor(0.5 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
      border = vim.g.border_style,
    }
  end

  require("mini.pick").setup({
    options = {
      content_from_bottom = true,
    },
    window = {
      prompt_prefix = " ❯ ",
      config = win_config,
    },
    mappings = {
      marked_to_quickfix = {
        char = "<C-q>",
        func = function()
          local items = MiniPick.get_picker_matches().marked or {}
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

  vim.keymap.set("n", "<leader>ff", function()
    MiniPick.builtin.files()
  end, { desc = "[F]ind [F]iles" })

  vim.keymap.set("n", "<leader>fo", function()
    MiniExtra.pickers.oldfiles()
  end, { desc = "[F]ind [O]ldfiles" })

  vim.keymap.set("n", "<leader>gf", function()
    MiniExtra.pickers.git_files()
  end, { desc = "[F]ind [G]it files" })

  vim.keymap.set("n", "<leader>gw", function()
    MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
  end, { desc = "[G]rep current [W]ord" })

  vim.keymap.set("n", "<leader>fw", function()
    MiniPick.builtin.grep()
  end, { desc = "[F]ind [W]ord" })

  vim.keymap.set("n", "<leader>fg", function()
    MiniPick.builtin.grep_live()
  end, { desc = "[F]ind by [G]rep" })

  vim.keymap.set("n", "<leader>fr", function()
    MiniPick.builtin.resume()
  end, { desc = "[F]ind [R]esume" })

  vim.keymap.set("n", "<leader>fk", function()
    MiniExtra.pickers.keymaps()
  end, { desc = "[F]ind [K]eymaps" })

  vim.keymap.set("n", "<leader>fc", function()
    MiniExtra.pickers.commands()
  end, { desc = "[F]ind [C]ommands" })

  vim.keymap.set("n", "<leader>fd", function()
    MiniExtra.pickers.diagnostic()
  end, { desc = "[F]ind [D]iagnostics" })

  vim.keymap.set("n", "<leader>ft", function()
    MiniExtra.pickers.colorschemes()
  end, { desc = "[F]ind [T]hemes/Colorscheme" })

  vim.keymap.set("n", "<leader><leader>", function()
    MiniPick.builtin.buffers()
  end, { desc = "[ ] Find existing buffers" })

  vim.keymap.set("n", "<leader>fh", function()
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
  end, { desc = "[F]ind [H]elp" })

  vim.keymap.set("n", "<leader>f/", function()
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
  end, { desc = "[F]ind [/] in current buffer" })

  vim.keymap.set("n", "<leader>fe", function()
    MiniExtra.pickers.explorer({}, {
      source = {
        name = " Explorer ",
      },
      options = {
        content_from_bottom = false,
      },
      window = {
        config = {
          anchor = "SE",
          height = vim.api.nvim_win_get_height(0),
          width = math.floor(0.2 * vim.o.columns),
          col = vim.o.columns,
        },
      },
    })
  end, { desc = "[F]ind in Mini [E]xplorer" })

  vim.keymap.set("n", "<leader>fn", function()
    MiniPick.builtin.files({}, {
      source = {
        name = "Neovim config",
        cwd = vim.fn.stdpath("config"),
      },
    })
  end, { desc = "[F]ind [N]vim config" })

  vim.keymap.set("n", "<leader>f.", function()
    MiniPick.builtin.files({}, {
      source = {
        name = "Dotfiles",
        cwd = os.getenv("HOME") .. "/dotfiles",
      },
    })
  end, { desc = "[F]ind [Dot]files directory" })

  vim.keymap.set("n", "<leader>fb", function()
    local builtin = MiniPick.start({
      source = {
        name = " Pick ",
        items = vim.fn.getcompletion("Pick ", "cmdline"),
      },
    })
    if builtin ~= nil then
      vim.cmd("Pick " .. builtin)
    end
  end, { desc = "[F]ind [B]uiltin Pick Commands" })

  vim.keymap.set("n", "<leader>gc", function()
    local git_commands = MiniPick.start({
      source = {
        name = " Git ",
        items = vim.fn.getcompletion("Git ", "cmdline"),
      },
    })
    if git_commands ~= nil then
      vim.cmd("Git " .. git_commands)
    end
  end, { desc = "Find [G]it [C]ommands" })

  local miniai = require("mini.ai")
  miniai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      D = MiniExtra.gen_ai_spec.diagnostic(),
      I = MiniExtra.gen_ai_spec.indent(),
      L = MiniExtra.gen_ai_spec.line(),
      N = MiniExtra.gen_ai_spec.number(),
      o = miniai.gen_spec.treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }, {}),
      u = miniai.gen_spec.function_call(), -- u for "Usage"
      U = miniai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      c = miniai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
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

  local minihipatterns = require("mini.hipatterns")
  minihipatterns.setup({
    highlighters = {
      hex_color = minihipatterns.gen_highlighter.hex_color(),
      todo = MiniExtra.gen_highlighter.words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      hack = MiniExtra.gen_highlighter.words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      note = MiniExtra.gen_highlighter.words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
      fixme = MiniExtra.gen_highlighter.words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
    },
  })

  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = { add = "+", change = "~", delete = "-" },
    },
  })
  vim.keymap.set("n", "<leader>gd", MiniDiff.toggle_overlay, { desc = "Toggle Diff Overlay" })

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
