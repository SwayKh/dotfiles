return {
  -- There's a fork of nvim-cmp for much better performance
  -- try it out sometime, Here's the PR https://github.com/hrsh7th/nvim-cmp/pull/1980
  -- "yioneko/nvim-cmp",
  -- branch = "perf",
  -- "hrsh7th/nvim-cmp",
  --
  "yioneko/nvim-cmp",
  branch = "perf",
  event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
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
  end,
}
