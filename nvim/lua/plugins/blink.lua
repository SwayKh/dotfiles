-- require("blink.cmp").setup({
--   keymap = {
--     preset = "default",
--     -- change default tab mappings for snippets
--     ["<C-j>"] = { "snippet_forward", "fallback" },
--     ["<C-k>"] = { "snippet_backward", "fallback" },
--   },
--
--   appearance = {
--     highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
--     use_nvim_cmp_as_default = false,
--     nerd_font_variant = "normal",
--     kind_icons = {
--       Supermaven = "",
--       Codeium = "",
--       Array = "󰅪",
--       Boolean = "⊨",
--       Key = "󰌆",
--       Namespace = "󰅪",
--       Null = "NULL",
--       Number = "#",
--       Object = "󰀚",
--       Package = "󰏗",
--       String = "󰀬",
--       TypeParameter = "󰊄",
--       Text = "󰉿",
--       Method = "󰆧",
--       Function = "󰊕",
--       Constructor = "",
--       Field = "󰜢",
--       Variable = "󰀫",
--       Class = "󰠱",
--       Interface = "",
--       Module = "",
--       Property = "󰜢",
--       Unit = "󰑭",
--       Value = "󰎠",
--       Enum = "",
--       Keyword = "󰌋",
--       Snippet = "",
--       Color = "󰏘",
--       File = "󰈙",
--       Reference = "󰈇",
--       Folder = "󰉋",
--       EnumMember = "",
--       Constant = "󰏿",
--       Struct = "󰙅",
--       Event = "",
--       Operator = "󰆕",
--     },
--   },
--
--   completion = {
--     list = { selection = "auto_insert" },
--     accept = { auto_brackets = { enabled = true } },
--     menu = {
--       min_width = 45,
--       border = vim.g.border_style,
--       scrolloff = 2,
--       scrollbar = false,
--       draw = {
-- columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } },
-- components = {
--   label = { width = { fill = false } }, -- default is true
--   label_description = { width = { fill = true } },
-- },
--       },
--     },
--     documentation = {
--       auto_show = true,
--       window = {
--         border = vim.g.border_style,
--         min_width = 45,
--         direction_priority = {
--           menu_north = { "e", "w" },
--           menu_south = { "e", "w" },
--         },
--       },
--     },
--     ghost_text = { enabled = false },
--   },
--
--   signature = {
--     enabled = true,
--     window = {
--       direction_priority = { "n", "s" },
--       border = vim.g.border_style,
--     },
--   },
--
--   fuzzy = {
--     prebuilt_binaries = {
--       download = true,
--       force_version = "v0.7.1",
--     },
--   },
--
--   sources = {
--     completion = {
--       enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
--     },
--     providers = {
--       lsp = { fallback_for = { "lazydev" } },
--       lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
--     },
--   },
--
--   snippets = {
--     -- Function to use when expanding LSP provided snippets
--     expand = function(snippet)
--       vim.snippet.expand(snippet)
--     end,
--     -- Function to use when checking if a snippet is active
--     active = function(filter)
--       return vim.snippet.active(filter)
--     end,
--     -- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
--     jump = function(direction)
--       vim.snippet.jump(direction)
--     end,
--   },
--
--   opts_extend = { "sources.completion.enabled_providers" },
-- })

-- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "BlinkCmpLabel", { link = "NormalFloat" })
-- vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "NormalFloat" })

require("blink.cmp").setup({
  fuzzy = {
    prebuilt_binaries = {
      force_version = "v0.6.2",
    },
  },
  highlight = {
    ns = vim.api.nvim_create_namespace("blink_cmp"),
    use_nvim_cmp_as_default = false,
  },
  nerd_font_variant = "normal",
  keymap = {
    preset = "default",
  },
  -- experimental auto-brackets support
  accept = { auto_brackets = { enabled = true } },
  -- experimental signature help support
  trigger = { signature_help = { enabled = true } },
  sources = {
    completion = {
      enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
    },
    providers = {
      lsp = { fallback_for = { "lazydev" } },
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
    },
  },
  windows = {
    autocomplete = {
      min_width = 35,
      border = vim.g.border_style,
      selection = "preselect",
      gap = 1,
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } },
        components = {
          label = { width = { fill = false } }, -- default is true
          label_description = { width = { fill = true } },
        },
      },
    },
    documentation = {
      border = vim.g.border_style,
      min_width = 45,
      auto_show = true,
      direction_priority = {
        autocomplete_north = { "e", "w" },
        autocomplete_south = { "e", "w" },
      },
    },
    signature_help = {
      direction_priority = { "s", "n" },
    },
  },
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
  opts_extend = { "sources.completion.enabled_providers" },
})

return {}
