return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    enabled = true,
    config = function()
      -- vim.cmd.colorscheme("sonokai")
      vim.cmd.colorscheme("catppuccin-macchiato")
      vim.opt.background = "dark"
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
  },
  {
    "sainnhe/sonokai",
    priority = 1000,
    name = "sonokai",
    enabled = false,
  },
  --   {
  --     "dylanaraps/wal.vim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "ribru17/bamboo.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "hoprr/calvera-dark.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "daschw/leaf.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "Yazeed1s/oh-lucy.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "Matsuuu/pinkmare",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "tanvirtin/monokai.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "cocopon/iceberg.vim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "dracula/vim",
  --     lazy = true,
  --     priority = 1000,
  --     name = "dracula",
  --   },
  --   {
  --     "EdenEast/nightfox.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "ellisonleao/gruvbox.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "folke/tokyonight.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "jnurmine/zenburn",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "junegunn/seoul256.vim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "ku1ik/vim-monokai",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "lifepillar/vim-solarized8",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "marko-cerovac/material.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "mhartington/oceanic-next",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "navarasu/onedark.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "nlknguyen/papercolor-theme",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "nordtheme/vim",
  --     lazy = true,
  --     priority = 1000,
  --     name = "nordtheme",
  --   },
  --   {
  --     "projekt0n/github-nvim-theme",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "rebelot/kanagawa.nvim",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "romainl/apprentice",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "rose-pine/neovim",
  --     lazy = true,
  --     priority = 1000,
  --     name = "rose-pine",
  --   },
  --   {
  --     "sainnhe/everforest",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "sainnhe/gruvbox-material",
  --     lazy = true,
  --     priority = 1000,
  --   },
  --   {
  --     "tomasiser/vim-code-dark",
  --     lazy = true,
  --     priority = 1000,
  --   },
}
