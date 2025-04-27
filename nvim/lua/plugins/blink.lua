require("blink.cmp").setup({
  appearance = {
    highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
    kind_icons = vim.g.kind_icons,
  },

  fuzzy = {
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
    prebuilt_binaries = { download = true },
  },

  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
    completion = {
      list = {
        selection = {
          auto_insert = true,
          preselect = false,
        },
      },
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
    min_keyword_length = 0,
    providers = {
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100, fallbacks = { "lsp" } },
      path = { opts = { show_hidden_files_by_default = true } },
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
    list = { selection = { preselect = true, auto_insert = true } },
    menu = {
      min_width = 40,
      max_height = 20,
      border = vim.g.border_style,
      scrolloff = 2,
      scrollbar = false,
      draw = {
        columns = { { "kind_icon" }, { "label", "kind", "source_name", gap = 1 } },
        align_to = "none",
        components = {
          label = { width = { min = 20, fill = true } }, -- default is true
          kind = { width = { fill = false } },
          label_description = { width = { fill = true } },
          source_name = {
            width = { fill = false },
            text = function(ctx)
              return "[" .. ctx.source_name .. "]"
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = {
        border = vim.g.border_style,
        min_width = 35,
        direction_priority = {
          menu_north = { "e", "w" },
          menu_south = { "e", "w" },
        },
      },
    },
    ghost_text = { enabled = false },
  },
})
