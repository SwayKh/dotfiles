return {
  -- There's a fork of nvim-cmp for much better performance
  -- try it out sometime, Here's the PR https://github.com/hrsh7th/nvim-cmp/pull/1980
  -- "yioneko/nvim-cmp",
  -- branch = "perf",
  -- "hrsh7th/nvim-cmp",
  --
  "yioneko/nvim-cmp",
  branch = "perf",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- For cmdline suggestions
  },
  config = function()
    local cmp = require("cmp")

    local border_opts = {
      border = "none",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      scrollbar = false,
    }
    local max_width = 30
    local kind_icons = {
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
          vim_item.abbr = string.sub(vim_item.abbr .. string.rep(" ", max_width), 1, max_width)
          vim_item.kind = (kind_icons[vim_item.kind] or "") .. " " .. vim_item.kind
          vim_item.menu = ({
            nvim_lsp = "[Lsp]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            buffer = "[Buffer]",
            codeium = "[Codeium]",
            supermaven = "[SuperMaven]",
            luasnip = "[LuaSnip]",
          })[entry.source.name]
          return vim_item
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
