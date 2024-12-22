require("blink.cmp").setup({
  fuzzy = {
    prebuilt_binaries = {
      download = true,
      force_version = "v0.8.1",
    },
  },

  keymap = {
    preset = "default",
    cmdline = {
      preset = "super-tab",
    },
  },

  appearance = {
    highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
    kind_icons = {
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
  },

  completion = {
    list = { selection = "auto_insert" },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      min_width = 35,
      border = vim.g.border_style,
      scrolloff = 2,
      scrollbar = false,
      draw = {
        columns = { { "kind_icon" }, { "label", "kind", "source_name", gap = 1 } },
        components = {
          label = { width = { min = 20, fill = true } }, -- default is true
          label_description = { width = { fill = true } },
          kind = { width = { fill = true } },
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

  signature = {
    enabled = true,
    window = {
      direction_priority = { "n", "s" },
      border = vim.g.border_style,
    },
  },

  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    cmdline = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      -- Commands
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end,
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

  -- opts_extend = { "sources.default" },
})

return {}
