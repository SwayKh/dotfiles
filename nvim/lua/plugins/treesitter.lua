return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  -- event = "VeryLazy",
  -- event = { "BufReadPost", "BufNewFile" },
  event = { "VeryLazy", "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Start, Add support for dotfiles, taken from LazyVim
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
        "rasi",
        "hyprlang",
        "regex",
      },
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      sync_install = true,
      auto_install = true,
      autopairs = { enable = true },
      rainbow = { enable = true },
      indent = { enable = true },
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
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
  end,
}
