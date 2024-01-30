return {
  -- Add indentation guides even on blank lines
  "lukas-reineke/indent-blankline.nvim",
  -- lazy = true,
  -- event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  main = "ibl",
}
