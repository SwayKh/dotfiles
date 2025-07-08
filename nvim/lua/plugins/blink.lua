require("blink.cmp").setup({
  fuzzy = {
    implementation = "lua",
    prebuilt_binaries = { download = false },
  },

  appearance = { nerd_font_variant = "normal" },

  cmdline = {
    completion = {
      list = { selection = { auto_insert = true, preselect = false } },
      menu = { auto_show = true },
    },
  },

  keymap = { preset = "default" },

  signature = {
    enabled = true,
    window = {
      direction_priority = { "n", "s" },
      border = vim.g.border_style,
    },
  },

  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100, fallbacks = { "lsp" } },
      lsp = { max_items = 100 },
      path = { opts = { show_hidden_files_by_default = true } },
      snippets = { score_offset = 0, min_keyword_length = 2 },
      buffer = {
        opts = {
          get_bufnrs = function()
            return vim.tbl_filter(function(bufnr)
              return vim.bo[bufnr].buftype == ""
            end, vim.api.nvim_list_bufs())
          end,
        },
      },
    },
  },

  completion = {
    accept = { auto_brackets = { enabled = true } },
    list = { max_items = 100, selection = { preselect = true, auto_insert = true } },
    ghost_text = { enabled = false },
    documentation = {
      auto_show = true,
      treesitter_highlighting = false,
      window = {
        border = vim.g.border_style,
        min_width = 40,
        direction_priority = {
          menu_north = { "e", "w" },
          menu_south = { "e", "w" },
        },
      },
    },
    menu = {
      min_width = 40,
      max_height = 30,
      border = vim.g.border_style,
      scrolloff = 0,
      scrollbar = false,
      draw = {
        align_to = "label",
        padding = { 0, 1 },
        cursorline_priority = 0,
        gap = 10,
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind", "source_name", gap = 1 } },
        components = {
          source_name = {
            text = function(ctx)
              return "[" .. ctx.source_name .. "]"
            end,
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          label = {
            text = function(ctx)
              return ctx.label .. ctx.label_detail
            end,
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
          kind_icons = {
            text = function(ctx)
              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return ctx.icon_gap .. kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      },
    },
  },
})
