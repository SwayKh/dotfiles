return {
  {
    "catppuccin/nvim",
    priority = 1000,
    enabled = true,
    name = "catppuccin",
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
  --    {
  --      "sainnhe/sonokai",
  --    },
  --   {
  --     "dylanaraps/wal.vim",
  --   },
  --   {
  --     "ribru17/bamboo.nvim",
  --   },
  --   {
  --     "hoprr/calvera-dark.nvim",
  --   },
  --   {
  --     "daschw/leaf.nvim",
  --   },
  --   {
  --     "Yazeed1s/oh-lucy.nvim",
  --   },
  --   {
  --     "Matsuuu/pinkmare",
  --   },
  --   {
  --     "tanvirtin/monokai.nvim",
  --   },
  --   {
  --     "cocopon/iceberg.vim",
  --   },
  --   {
  --     "dracula/vim",
  --     name = "dracula",
  --   },
  --   {
  --     "EdenEast/nightfox.nvim",
  --   },
  --   {
  --     "ellisonleao/gruvbox.nvim",
  --   },
  --   {
  --     "folke/tokyonight.nvim",
  --   },
  --   {
  --     "jnurmine/zenburn",
  --   },
  --   {
  --     "junegunn/seoul256.vim",
  --   },
  --   {
  --     "ku1ik/vim-monokai",
  --   },
  --   {
  --     "lifepillar/vim-solarized8",
  --   },
  --   {
  --     "marko-cerovac/material.nvim",
  --   },
  --   {
  --     "mhartington/oceanic-next",
  --   },
  --   {
  --     "navarasu/onedark.nvim",
  --   },
  --   {
  --     "nlknguyen/papercolor-theme",
  --   },
  --   {
  --     "nordtheme/vim",
  --     name = "nord",
  --   },
  --   {
  --     "projekt0n/github-nvim-theme",
  --   },
  --   {
  --     "rebelot/kanagawa.nvim",
  --   },
  --   {
  --     "romainl/apprentice",
  --   },
  --   {
  --     "rose-pine/neovim",
  --     name = "rose-pine",
  --   },
  --   {
  --     "sainnhe/everforest",
  --   },
  --   {
  --     "sainnhe/gruvbox-material",
  --   },
  --   {
  --     "tomasiser/vim-code-dark",
  --   },
}
