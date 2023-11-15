return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
}
