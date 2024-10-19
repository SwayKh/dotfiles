-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({
  source = "otavioschwanck/arrow.nvim",
})

add({
  source = "yioneko/nvim-cmp",
  checkout = "perf",
  depends = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- For cmdline suggestions
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
  },
})

add({
  source = "sainnhe/everforest",
})

add({
  source = "stevearc/dressing.nvim",
})
later(function()
  require("arrow").setup({
    show_icons = true,
    leader_key = ";", -- Recommended to be a single key
    buffer_leader_key = "m", -- Per Buffer Mappings
    global_bookmarks = false,
    window = {
      border = "none",
    },
  })
end)
add({
  source = "stevearc/conform.nvim",
})
add({
  source = "ibhagwan/fzf-lua",
})
add({
  source = "christoomey/vim-tmux-navigator",
})
add({
  source = "mfussenegger/nvim-lint",
})
add({
  source = "neovim/nvim-lspconfig",
  depends = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp", -- for autocompletion
    "nvim-lua/plenary.nvim",
    "folke/lazydev.nvim",
  },
})
add({
  source = "iamcco/markdown-preview.nvim",
  hooks = {
    post_checkout = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
})
add({
  source = "folke/noice.nvim",
  depends = {
    "MunifTanjim/nui.nvim",
  },
})
add({
  source = "supermaven-inc/supermaven-nvim",
})
add({
  source = "akinsho/toggleterm.nvim",
})
add({
  source = "nvim-treesitter/nvim-treesitter",
  depends = {
    "windwp/nvim-ts-autotag",
  },
  hooks = {
    post_checkout = function()
      vim.cmd("TSUpdate")
    end,
  },
})
add({
  source = "folke/trouble.nvim",
})

now(function()
  -- " Available values: 'hard', 'medium'(default), 'soft'
  vim.g.everforest_background = "hard"
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_ui_contrast = "high"
  vim.g.everforest_diagnostic_text_highlight = 1
  vim.g.everforest_diagnostic_line_highlight = 1
  -- vim.g.everforest_better_performance = 1
  vim.g.everforest_transparent_background = 2
  vim.g.everforest_float_style = "dim"
  vim.g.everforest_diagnostic_virtual_text = "colored"
  vim.g.everforest_dim_inactive_windows = 1
  vim.cmd.colorscheme("everforest")
end)

later(function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  local luasnip = require("luasnip")
  luasnip.config.setup({
    history = false,
    updateevents = "TextChanged,TextChangedI",
  })

  -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
  require("luasnip.loaders.from_vscode").lazy_load()

  local border_opts = {
    border = "none",
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    scrollbar = false,
  }
  cmp.setup({
    enabled = true,
    completion = {
      autocompletion = true,
      completeopt = "menu,menuone,preview,noinsert", -- noselect,
    },
    -- The completeopt 'noselect' option does this
    preselect = cmp.PreselectMode.Item,

    performance = {
      debounce = 0, -- default is 60ms
      throttle = 0, -- default is 30ms
    },

    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },

    matching = {
      dissallow_fuzzy_matching = false,
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- previous suggestion
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- next suggestion
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { "i", "c" }
      ),
      ["<C-k>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-j>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
      -- ["<C-k>"] = cmp.mapping(function(fallback)
      --   if vim.snippet.active({ direction = 1 }) then
      --     vim.snippet.jump(1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      -- ["<C-j>"] = cmp.mapping(function(fallback)
      --   if vim.snippet.active({ direction = -1 }) then
      --     vim.snippet.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
    }),

    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "lazydev", priority = 300, group_index = 0 },
      { name = "luasnip", priority = 1000, max_item_count = 5 },
      { name = "supermaven", priority = 500, max_item_count = 5 },
      { name = "nvim_lsp", priority = 400, max_item_count = 20 },
      { name = "buffer", priority = 200, max_item_count = 10 },
      { name = "path", priority = 100, max_item_count = 10 },
      -- { name = "codeium", priority = 1000, max_item_count = 5 },
    }),

    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
      -- documentation = {
      --   border = "rounded",
      --   winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      --   scrollbar = false,
      -- },
    },

    view = {
      entries = {
        follow_cursor = true,
      },
    },

    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          show_labelDetails = true,
          menu = {
            nvim_lsp = "[Lsp]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            buffer = "[Buffer]",
            codeium = "[Codeium]",
            luasnip = "[LuaSnip]",
          },
          ellipsis_char = "...",
          symbol_map = {
            Supermaven = "",
            Codeium = "",
            Array = "󰅪",
            Boolean = "⊨",
            Key = "󰌆",
            Namespace = "󰅪",
            Null = "NULL",
            Number = "#",
            Object = "󰀚",
            Package = "󰏗",
            String = "󰀬",
            TypeParameter = "󰊄",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
          },
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = "    " .. (strings[1] or "") .. "    " .. (strings[2] or "") .. ""
        kind.menu = "    " .. (strings[2] or "") .. ""
        kind.abbr = string.sub(kind.abbr .. string.rep(" ", 25), 1, 25)

        return kind
      end,
    },

    experimental = {
      native_menu = false,
      ghost_text = false,
    },
  })
  -- `/` cmdline setup.
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  -- `:` cmdline setup.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "buffer" },
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })
end)

later(function()
  local dressing = require("dressing")
  dressing.setup({
    input = {
      -- Set to false to disable the vim.ui.input implementation
      enabled = true,

      -- Default prompt string
      default_prompt = "Input:",

      -- Can be 'left', 'right', or 'center'
      title_pos = "center",

      -- When true, <Esc> will close the modal
      insert_only = true,

      -- When true, input will start in insert mode.
      start_in_insert = true,

      -- These are passed to nvim_open_win
      border = "none",
      -- 'editor' and 'win' will default to being centered
      relative = "cursor",

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      prefer_width = 40,
      width = nil,
      -- min_width and max_width can be a list of mixed types.
      -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },

      buf_options = {},
      win_options = {
        -- Disable line wrapping
        wrap = false,
        -- Indicator for when text exceeds window
        list = true,
        listchars = "precedes:…,extends:…",
        -- Increase this for more context when text scrolls off the window
        sidescrolloff = 0,
      },

      -- Set to `false` to disable
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },

      override = function(conf)
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        return conf
      end,

      -- see :help dressing_get_config
      get_config = nil,
    },
    select = {
      -- Set to false to disable the vim.ui.select implementation
      enabled = true,

      -- Priority list of preferred vim.select implementations
      backend = { "fzf_lua", "telescope", "fzf", "builtin", "nui" },

      -- Trim trailing `:` from prompt
      trim_prompt = true,

      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = nil,

      -- Options for fzf selector
      fzf = {
        window = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Options for fzf-lua
      fzf_lua = {
        -- winopts = {
        --   height = 0.5,
        --   width = 0.5,
        -- },
      },

      -- Options for nui Menu
      nui = {
        position = "50%",
        size = nil,
        relative = "editor",
        border = {
          style = "none",
        },
        buf_options = {
          swapfile = false,
          filetype = "DressingSelect",
        },
        win_options = {
          winblend = 0,
        },
        max_width = 80,
        max_height = 40,
        min_width = 40,
        min_height = 10,
      },

      -- Options for built-in selector
      builtin = {
        -- Display numbers for options and set up keymaps
        show_numbers = true,
        -- These are passed to nvim_open_win
        border = "none",
        -- 'editor' and 'win' will default to being centered
        relative = "editor",

        buf_options = {},
        win_options = {
          cursorline = true,
          cursorlineopt = "both",
        },

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- the min_ and max_ options can be a list of mixed types.
        -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },

        -- Set to `false` to disable
        mappings = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,
      },

      -- Used to override format_item. See :help dressing-format
      format_item_override = {},

      -- see :help dressing_get_config
      get_config = nil,
    },
  })
end)

later(function()
  if vim.g.started_by_firenvim then
    opts.format_on_save = false
    opts.format_after_save = false
  end
  require("conform").setup({
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      html = { "djlint", "prettierd", "prettier" },
      templ = { "djlint", "templ" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      rasi = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier", "injected" },
      norg = { "injected" },
      graphql = { "prettierd", "prettier" },
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
      sh = { "beautysh", "shfmt" },
      python = { "isort", "ruff" },
      zig = { "zigfmt" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
      ["*"] = { "codespell" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      -- Dealing with old version of prettierd that doesn't support range formatting
      prettierd = {
        range_args = false,
      },
    },
    log_level = vim.log.levels.TRACE,
    format_after_save = { timeout_ms = 500, lsp_fallback = true, async = true, quiet = true },
  })
  vim.keymap.set("n", "=", function()
    require("conform").format({ async = true, lsp_fallback = true }, function(err)
      if not err then
        if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        end
      end
    end)
  end, { desc = "Format buffer" })
end)

later(function()
  local fzf = require("fzf-lua")

  local config = require("fzf-lua.config")
  local t_actions = require("trouble.sources.fzf").actions
  config.defaults.actions.files["ctrl-t"] = t_actions.open

  fzf.setup({
    "fzf-native", -- profiles, options {"default", "telescope", "fzf-native", "fzf-tmux", "fzf-vim"} + :fzflua profiles
    preview = { layout = "horizontal" },
    winopts = {
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- On by default
      -- border = { "none", "single", "double", "rounded", "solid", "shadow" },
      title = " Fzf ",
      title_pos = "center",
      height = 0.80, -- window height
      width = 0.80, -- window width
      row = 0.50, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      preview = {
        layout = "horizontal",
        vertical = "down:50%",
        horizontal = "right:50%",
      },
    },
    keymap = {
      fzf = {
        ["alt-a"] = "toggle-all",
        ["ctrl-q"] = "select-all+accept",
      },
    },
    fzf_opts = {
      ["--layout"] = "default",
      ["--no-scrollbar"] = "",
      ["--header"] = " ",
      ["--marker"] = "+",
      -- ["--info"] = "inline", -- This puts the item count next to input
    },

    grep = {
      prompt = " Find ❯ ",
      rg_opts = [[--column --line-number --no-heading --color=always --hidden --smart-case --max-columns=4096 -e]],
      no_header_i = true,
      rg_glob = true, -- enable glob parsing by default to all
      -- grep providers? (default:false)
      glob_flag = "--iglob", -- for case sensitive globs use '--glob'
      glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
    },
    files = {
      prompt = " Files ❯ ",
      no_header_i = true,
      cwd_prompt = false,
      git_icons = true,
      find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      rg_opts = [[--color=never --files --no-ignore --hidden --follow -g "!.git"]],
      fd_opts = [[--color=never --type f --no-ignore --hidden --follow --exclude .git --ignore-file ~/home.gitignore]],
    },
    args = { prompt = " ❯ " },
    oldfiles = { prompt = " Recents ❯ " },
    buffers = { prompt = " Buffers ❯ ", no_header_i = true },
    colorschemes = { prompt = " Themes ❯ " },
    keymaps = { prompt = " Keymaps ❯ " },
    git = {
      files = { prompt = " Git Files ❯ " },
      status = { prompt = " ❯ " },
      commits = { prompt = " ❯ " },
    },
    helptags = {
      prompt = ":",
      -- preview_opts = "hidden",
      winopts = {
        row = 1,
        -- width = vim.api.nvim_win_get_width(0),
        width = 1,
        height = 0.4,
      },
    },
  })

  vim.keymap.set("n", "<leader>gf", fzf.git_files, { silent = true, desc = "Search [G]it [F]iles" }) --git_files
  vim.keymap.set("n", "<leader>s?", fzf.oldfiles, { silent = true, desc = "[S]earch Recent Files" })
  vim.keymap.set("n", "<leader>sf", fzf.files, { silent = true, desc = "[S]earch [F]iles" }) --find_files
  vim.keymap.set("n", "<leader>sg", fzf.live_grep, { silent = true, desc = "[S]earch by [G]rep" }) --live_grep
  vim.keymap.set("n", "<leader>sh", fzf.help_tags, { silent = true, desc = "[S]earch [H]elp" }) --help_tags
  vim.keymap.set("n", "<leader>gw", fzf.grep_cWORD, { silent = true, desc = "[G]rep current [W]ord" }) --grep_string
  vim.keymap.set("n", "<leader>sr", fzf.resume, { silent = true, desc = "[S]earch [R]esume" }) --resume
  vim.keymap.set("n", "<leader>sk", fzf.keymaps, { silent = true, desc = "[S]earch [K]eymaps" })
  vim.keymap.set("n", "<leader>sb", fzf.builtin, { silent = true, desc = "[S]earch [B]uiltin FzfLua commands" })
  vim.keymap.set("n", "<leader>st", fzf.colorschemes, { silent = true, desc = "[S]earch [T]hemes/Colorscheme" })
  vim.keymap.set("n", "<leader>sc", fzf.commands, { silent = true, desc = "[S]earch [C]ommands" })
  vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { silent = true, desc = "[S]earch [D]iagnostics" }) --diagnostics

  vim.keymap.set("n", "<leader><leader>", fzf.buffers, { silent = true, desc = "[ ] Find existing buffers" })

  vim.keymap.set("n", "<leader>sn", function()
    require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
  end, { silent = true, desc = "[S]earch [N]vim config" })

  vim.keymap.set("n", "<leader>s.", function()
    require("fzf-lua").files({ cwd = "$HOME/dotfiles" })
  end, { silent = true, desc = "[S]earch [N]vim config" })

  vim.keymap.set("n", "<leader>s/", function()
    require("fzf-lua").grep_curbuf({
      fzf_opts = {
        ["--layout"] = "reverse",
      },
      winopts = {
        title = " Grep Buffer ",
        title_pos = "center",
        preview = { hidden = "hidden" },
        height = 0.40, -- window height
        width = vim.api.nvim_win_get_width(0),
        row = 1, -- window row position (0=top, 1=bottom)
      },
    })
  end, { desc = "[S]earch [/] in current buffer" })

  vim.keymap.set("n", "<leader>lr", function()
    fzf.fzf_exec(require("config.utils").pluginNames(), {
      prompt = "Select a plugin > ",
      actions = {
        ["default"] = function(selected)
          vim.cmd("Lazy reload " .. selected[1])
        end,
      },
      winopts = {
        title = " Reload Plugins ",
        title_pos = "center",
        preview = { hidden = "hidden" },
        height = 0.50, -- window height
        width = 0.40, -- window width
        row = 0.50, -- window row position (0=top, 1=bottom)
        col = 0.50, -- window col position (0=left, 1=right)
      },
    })
  end, { desc = "[L]azy [R]eload plugin of choice" })
end)

-- later(function()
--   require("vim-tmux-navigator").setup()
-- end)

later(function()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
    python = { "pylint", "ruff" },
    go = { "golangcilint" },
    bash = { "shellcheck" },
    cpp = { "cpplint" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })
  vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
end)

later(function()
  local lspconfig = require("lspconfig")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local util = require("lspconfig.util")
  local lspui = require("lspconfig.ui.windows")

  require("lazydev").setup({
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  })
  lspui.default_options.border = "none"

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      map("<leader>rs", ":LspRestart", "LSP [R]e[S]tart")

      map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]definition")
      map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
      map("gi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
      map("gD", require("fzf-lua").lsp_declarations, "[G]oto [D]eclaration")
      map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]definition")
      -- map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]symbols")
      -- map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]symbols")

      -- See `:help K` for why this keymap
      map("K", vim.lsp.buf.hover, "Hover Documentation")
      -- map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Diagnostic keymaps
      -- Don't need these right now
      map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
      map("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
      map("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
      map("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

      -- Lesser used LSP functionality
      map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      map("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
      end

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.lsp.inlay_hint.enable(true, { event.buf })
        map("<leader>ti", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle [I]nlay Hints")
      end

      vim.diagnostic.config({
        signs = {
          active = true,
          values = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "󰌶" },
            { name = "DiagnosticSignInfo", text = "" },
          },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "none",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  })

  local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

  local servers = {
    -- bashls = {}, -- Bash
    clangd = {}, -- C/C++
    marksman = {}, -- Markdown lsp
    sqlls = {}, -- SQL
    eslint = {}, -- React/NextJS/Svelte
    emmet_language_server = {}, -- HTML
    ts_ls = {}, -- Javascript, TypeScript
    html = {}, -- HTML
    htmx = {}, -- HTMX
    cssls = {}, -- CSS
    tailwindcss = {}, -- Tailwind CSS
    templ = {}, -- Templ
    pyright = {}, -- Python
    gopls = { -- Golang
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = false,
          analyses = {
            unusedparams = true,
            unreachable = true,
          },
          -- report vulnerabilities
          vulncheck = "Imports",
          staticcheck = true,
          gofumpt = true,
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = true,
          },
          completion = {
            callSnippet = "Replace",
            displayContext = 10,
            keywordSnippet = "Both",
          },
          diagnostics = {
            globals = { "vim" },
            disable = { "missing-fields", "undefined-global" },
          },
          codeLens = {
            enable = true,
          },
          doc = {
            privateName = { "^_" },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    },
  }

  local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }

  mason.setup({
    ui = {
      border = "none",
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- FORMATTERS
    { "gofumpt" }, -- GO
    { "goimports" }, -- GO
    { "black" }, -- Python
    { "isort" }, -- Python
    { "prettierd" }, -- JS and Many More
    { "prettier" }, -- JS and Many More
    { "shfmt" }, -- Shell Script
    { "stylua" }, -- Lua

    -- LINTERS
    { "codespell" },
    -- { "eslint_d" },
    { "pylint" },
    { "shellcheck" },

    --DAP
    { "delve" },
    { "debugpy" },
  })
  mason_tool_installer.setup({
    ensure_installed = ensure_installed,

    auto_update = true,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
  })

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  mason_lspconfig.setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        lspconfig[server_name].setup(server)
      end,
    },
  })
end)

later(function()
  vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Preview Markdown" })
end)

later(function()
  -- require("mini.starter").setup() -- Won't work because mini is lazy loaded
  require("mini.align").setup()
  require("mini.bracketed").setup()
  require("mini.extra").setup()
  require("mini.files").setup()
  require("mini.git").setup()
  require("mini.icons").setup()
  -- require("mini.jump").setup({ mappings = { repeat_jump = "," } })
  require("mini.jump2d").setup({ view = { dim = true } })
  require("mini.notify").setup()
  require("mini.pairs").setup()
  require("mini.splitjoin").setup()
  require("mini.surround").setup()
  require("mini.tabline").setup()

  -- Mocks nvim-web-devicons, for plugins that don't support Mini.Icons
  -- MiniIcons.mock_nvim_web_devicons()
  vim.notify = require("mini.notify").make_notify()

  vim.keymap.set("n", "-", function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
    MiniFiles.open(path)
    MiniFiles.reveal_cwd()
  end, { desc = "Open Mini Files" })

  vim.keymap.set({ "n", "x" }, "<leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Show Git Status" })

  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = { add = "+", change = "~", delete = "-" },
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

  require("mini.hipatterns").setup({
    highlighters = {
      hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
      todo = require("mini.extra").gen_highlighter.words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      hack = require("mini.extra").gen_highlighter.words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      note = require("mini.extra").gen_highlighter.words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
      fixme = require("mini.extra").gen_highlighter.words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
    },
  })

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
end)

later(function()
  local noice = require("noice")
  noice.setup({
    lsp = {
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = "mini",
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = false, -- set to true to not show a message if hover is not available
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "notify",
        opts = {},
      },
      -- defaults for hover and signature help
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },

    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = "notify", -- default view for messages
      view_error = "notify", -- view for errors
      view_warn = "notify", -- view for warnings
      view_history = "messages", -- view for :messages
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },

    markdown = {
      hover = {
        ["|(%S-)|"] = vim.cmd.help, -- vim help links
        ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
      },
      highlights = {
        ["|%S-|"] = "@text.reference",
        ["@%S+"] = "@parameter",
        ["^%s*(Parameters:)"] = "@text.title",
        ["^%s*(Return:)"] = "@text.title",
        ["^%s*(See also:)"] = "@text.title",
        ["{%S-}"] = "@parameter",
      },
    },

    health = {
      checker = false,
    },

    presets = {
      command_palette = true,
      long_message_to_split = true,
      bottom_search = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },

    notify = {
      enabled = true,
      view = "notify",
    },

    views = {
      cmdline_popup = {
        position = {
          row = "10%",
          col = "50%",
        },
        size = {
          width = "30%",
          height = "auto",
        },
      },

      popupmenu = {
        relative = "editor",
        backend = "nui",
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "none",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  })
  vim.keymap.set("n", "<C-Esc>", function()
    require("noice").cmd("dismiss")
  end, { desc = "Dismiss Noice Notify Message" })
  vim.keymap.set("n", "<leader>nf", function()
    require("noice").cmd("fzf")
  end, { desc = "Open Noice Message history with fzf" })
end)

later(function()
  require("supermaven-nvim").setup({
    disable_inline_completion = true, -- disables inline completion for use with cmp
    disable_keymaps = true, -- disables built in keymaps for more manual control
  })
end)

later(function()
  require("toggleterm").setup({
    size = 15,
    shade_filetypes = {},
    open_mapping = [[<c-,>]],
    shade_terminal = true,
    shading_factor = -50,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    autochdir = true,
    float_opts = { border = "none" },
    highlights = {
      Normal = { link = "Normal" },
      NormalNC = { link = "NormalNC" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
      StatusLine = { link = "StatusLine" },
      StatusLineNC = { link = "StatusLineNC" },
      WinBar = { link = "WinBar" },
      WinBarNC = { link = "WinBarNC" },
    },
  })

  vim.keymap.set(
    "n",
    "<leader>th",
    "<Cmd>ToggleTerm direction=horizontal <CR>",
    { silent = true, desc = "[T]oggleTerm [H]orizontal" }
  )
  vim.keymap.set(
    "n",
    "<leader>tf",
    "<Cmd>ToggleTerm direction=float<CR>",
    { silent = true, desc = "[T]oggleTerm [F]loat" }
  )
  vim.keymap.set(
    "n",
    "<leader>tv",
    "<Cmd>ToggleTerm size=60 direction=vertical<CR>",
    { silent = true, desc = "[T]oggleTerm [V]ertical" }
  )
end)

later(function()
  -- Start, Add support for dotfiles, taken from LazyVim
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "bash",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "vim",
      "vimdoc",
      "yaml",
      "prisma",
      "markdown",
      "markdown_inline",
      "dockerfile",
      "gitignore",
      "query",
      "rasi",
      "hyprlang",
      "regex",
    },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    sync_install = true,
    auto_install = true,
    autopairs = { enable = true },
    rainbow = { enable = true },
    indent = { enable = false },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
  })
  require("nvim-ts-autotag").setup({
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "css",
      "lua",
      "xml",
      "php",
      "markdown",
    },
  })
end)

later(function()
  local trouble = require("trouble")
  trouble.setup({
    auto_jump = true, -- auto jump to the item when there's only one
    focus = true, -- Focus the window when opened
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    preview = {
      type = "main",
      -- Set to false, if you want the preview to always be a real loaded buffer.
      scratch = true,
    },
    win = {
      border = "none",
      size = 0.38, -- This weird size makes sense with the resize autocmd
    },
    modes = {
      symbols = {
        win = { position = "right" },
        focus = true,
      },
      diagnostics = {
        win = { position = "right" },
        focus = true,
      },
    },
  })

  vim.keymap.set(
    "n",
    "<leader>td",
    "<cmd>Trouble diagnostics toggle<cr>",
    { silent = true, desc = "Diagnostics (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tD",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { silent = true, desc = "Buffer Diagnostics (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tL",
    "<cmd>Trouble lsp toggle<cr>",
    { silent = true, desc = "LSP Definitions / references / ... (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tl",
    "<cmd>Trouble loclist toggle<cr>",
    { silent = true, desc = "Location List (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tq",
    "<cmd>Trouble qflist toggle<cr>",
    { silent = true, desc = "Quickfix List (Trouble)" }
  )
  vim.keymap.set(
    "n",
    "<leader>ds",
    "<cmd>Trouble symbols toggle<cr>",
    { silent = true, desc = "Document Symbols (Trouble)" }
  )
  vim.keymap.set("n", "[q", function(self)
    if require("trouble").is_open() then
      trouble.prev(self, { skip_groups = true, jump = true, focus = false })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, { silent = true, desc = "Previous Trouble/Quickfix Item" })
  vim.keymap.set("n", "]q", function(self)
    if require("trouble").is_open() then
      trouble.next(self, { skip_groups = true, jump = true, focus = false })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, { silent = true, desc = "Next Trouble/Quickfix Item" })
end)
