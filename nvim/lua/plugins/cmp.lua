-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
return {
  -- There's a fork of nvim-cmp for much better performance
  -- try it out sometime, Here's the PR https://github.com/hrsh7th/nvim-cmp/pull/1980
  -- "yioneko/nvim-cmp",
  -- branch = "perf",
  --
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
  -- event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- For cmdline suggestions
    "onsails/lspkind.nvim", -- vs-code like pictograms

    {
      "L3MON4D3/LuaSnip", -- snippet engine
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
  },
  config = function()
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
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
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
        -- I want to do fuzzy matching :)
        dissallow_fuzzy_matching = false,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- next suggestion
        ["<C-h>"] = cmp.mapping.scroll_docs(-4),
        ["<C-l>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          { "i", "c" }
        ),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "luasnip", priority = 1000, max_item_count = 5 },
        { name = "supermaven", priority = 500, max_item_count = 5 },
        { name = "nvim_lsp", priority = 400, max_item_count = 20 },
        { name = "lazydev", priority = 300, group_index = 0 },
        { name = "buffer", priority = 200, max_item_count = 10 },
        { name = "path", priority = 100, max_item_count = 10 },
        -- { name = "codeium", priority = 1000, max_item_count = 5 },
      }),

      window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
      },

      view = {
        entries = {
          follow_cursor = true,
        },
      },

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        -- format = lspkind.cmp_format({
        --   before = function(_, vim_item)
        --     vim_item.menu = ""
        --     vim_item.kind = ""
        --     vim_item.abbr = vim_item.abbr ... string.rep(" ", 30 - string.len(vim_item.abbr))
        --     return vim_item
        --   end,
        --   mode = "symbol_text",
        --   maxwidth = 50,
        --   show_labelDetails = true,
        --   menu = {
        --     nvim_lsp = "[LSP]",
        --     nvim_lua = "[Lua]",
        --     path = "[Path]",
        --     buffer = "[Buffer]",
        --     codeium = "[Codeium]",
        --     luasnip = "[LuaSnip]",
        --   },
        --   ellipsis_char = "...",
        --   symbol_map = {
        --     Supermaven = "",
        --     Codeium = "",
        --     Array = "󰅪",
        --     Boolean = "⊨",
        --     Class = "󰌗",
        --     Constructor = "",
        --     Key = "󰌆",
        --     Namespace = "󰅪",
        --     Null = "NULL",
        --     Number = "#",
        --     Object = "󰀚",
        --     Package = "󰏗",
        --     Property = "",
        --     Reference = "",
        --     Snippet = "",
        --     String = "󰀬",
        --     TypeParameter = "󰊄",
        --     Unit = "",
        --   },
        -- }),
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
  end,
}
