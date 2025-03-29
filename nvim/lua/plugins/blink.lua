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
    prebuilt_binaries = {
      download = true,
      force_version = "v1.0.0",
    },
  },

  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
  },
  keymap = {
    preset = "default",
  },

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
    },
  },

  snippets = {
    -- Function to use when expanding LSP provided snippets
    expand = function(snippet)
      vim.snippet.expand(snippet)
    end,
    -- Function to use when checking if a snippet is active
    active = function(filter)
      return vim.snippet.active(filter)
    end,
    -- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
    jump = function(direction)
      vim.snippet.jump(direction)
    end,
  },

  completion = {
    accept = { auto_brackets = { enabled = true } },
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    menu = {
      min_width = 35,
      border = vim.g.border_style,
      scrolloff = 2,
      scrollbar = false,
      draw = {
        columns = { { "kind_icon" }, { "label", "kind", "source_name", gap = 1 } },
        align_to = "cursor",
        components = {
          label = { width = { min = 20, fill = true } }, -- default is true
          label_description = { width = { fill = true } },
          kind = {
            width = { fill = true },
            text = function(ctx)
              return "" .. ctx.kind .. ""
            end,
          },
          source_name = {
            width = { fill = true },
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

  -- opts_extend = { "sources.default" },
})

return {}
