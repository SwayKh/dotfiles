require("blink.cmp").setup({
  fuzzy = {
    prebuilt_binaries = {
      force_version = "v0.5.1",
    },
  },
  highlight = {
    use_nvim_cmp_as_default = true,
  },
  nerd_font_variant = "normal",
  keymap = "default",
  -- experimental auto-brackets support
  accept = { auto_brackets = { enabled = true } },
  -- experimental signature help support
  trigger = { signature_help = { enabled = true } },
  sources = {
    completion = {
      enabled_providers = { "snippets", "lazydev", "lsp", "buffer", "path" },
    },
    providers = {
      lsp = {
        -- don't show LuaLS require statements when lazydev has items
        fallback_for = { "lazydev" },
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },
  windows = {
    autocomplete = {
      min_width = 45,
      border = vim.g.border_style,
      selection = "preselect",
      draw = "reversed",
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
