return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  -- event = "VeryLazy",
  -- event = { "BufReadPost", "BufNewFile" },
  event = { "VeryLazy", "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
    },
  },
  config = function()
    -- Start, Add support for dotfiles, taken from LazyVim
    local ensure_installed = {
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
    }

    require("nvim-treesitter.configs").setup({
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = ensure_installed,

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
        enable = false,
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
