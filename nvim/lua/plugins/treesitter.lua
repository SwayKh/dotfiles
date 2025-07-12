require("nvim-treesitter.configs").setup({
  sync_install = true,
  auto_install = true,
  autopairs = { enable = true },
  rainbow = { enable = true },
  indent = { enable = false },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
})
require("nvim-ts-autotag").setup({
  enable = true,
  filetypes = {
    "html",
    "javascript",
    "typescript",
    "svelte",
    "vue",
    "tsx",
    "jsx",
    "rescript",
    "css",
    "lua",
    "xml",
    "php",
    "markdown",
  },
})
