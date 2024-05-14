-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  lazy = true,
  -- event = { "InsertEnter", "CmdlineEnter" },
  event = "VeryLazy",
  dependencies = {
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets

    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- For cmdline suggestions

    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    luasnip.config.setup({})
    local lspkind = require("lspkind")

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
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   elseif luasnip.expand_or_locally_jumpable() then
        --     luasnip.expand_or_jump()
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_prev_item()
        --   elseif luasnip.locally_jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750, max_item_count = 3 },
        { name = "buffer", priority = 500, max_item_count = 5 },
        { name = "path", priority = 250, max_item_count = 5 },
        -- { name = "codeium" },
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
        format = lspkind.cmp_format({
          before = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
            return vim_item
          end,
          mode = "symbol_text",
          maxwidth = 80,
          ellipsis_char = "...",
          symbol_map = {
            Codeium = "",
            Array = "󰅪",
            Boolean = "⊨",
            Class = "󰌗",
            Constructor = "",
            Key = "󰌆",
            Namespace = "󰅪",
            Null = "NULL",
            Number = "#",
            Object = "󰀚",
            Package = "󰏗",
            Property = "",
            Reference = "",
            Snippet = "",
            String = "󰀬",
            TypeParameter = "󰊄",
            Unit = "",
          },
        }),
      },
      experimental = {
        native_menu = false,
        ghost_text = true,
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
      }, {
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
