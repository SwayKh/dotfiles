return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = { "BufReadPre", "BufNewFile" },
    },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "bash",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "vim",
        "vimdoc",
        "yaml",
        "prisma",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "gitignore",
        "query",
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      sync_install = false,
      auto_install = true,
      autopairs = { enable = true },
      rainbow = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
    })
  end,
}
