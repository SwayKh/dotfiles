return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
      vim.cmd.hi("Comment gui=none")
      -- vim.opt.background = "dark"
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
  },
  -- {
  --   "eldritch-theme/eldritch.nvim",
  --   lazy = true,
  -- },
  -- {
  --   "sainnhe/sonokai",
  --   lazy = true,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = true,
  -- },
  -- {
  --   "sainnhe/edge",
  --   lazy = true,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = true,
  -- },
  -- {
  --   "dracula/vim",
  --   name = "dracula",
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  -- },
  --
  -- {
  --   "dylanaraps/wal.vim",
  -- },
  -- {
  --   "ribru17/bamboo.nvim",
  -- },
  -- {
  --   "hoprr/calvera-dark.nvim",
  -- },
  -- {
  --   "daschw/leaf.nvim",
  -- },
  -- {
  --   "Yazeed1s/oh-lucy.nvim",
  -- },
  -- {
  --   "Matsuuu/pinkmare",
  -- },
  -- {
  --   "tanvirtin/monokai.nvim",
  -- },
  -- {
  --   "cocopon/iceberg.vim",
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  -- },
  -- {
  --   "jnurmine/zenburn",
  -- },
  -- {
  --   "junegunn/seoul256.vim",
  -- },
  -- {
  --   "ku1ik/vim-monokai",
  -- },
  -- {
  --   "lifepillar/vim-solarized",
  -- },
  -- {
  --   "marko-cerovac/material.nvim",
  -- },
  -- {
  --   "mhartington/oceanic-next",
  -- },
  -- {
  --   "nlknguyen/papercolor-theme",
  -- },
  -- {
  --   "nordtheme/vim",
  --   name = "nord",
  -- },
  -- {
  --   "projekt0n/github-nvim-theme",
  -- },
  -- {
  --   "romainl/apprentice",
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  -- },
  -- {
  --   "sainnhe/everforest",
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  -- },
  -- {
  --   "tomasiser/vim-code-dark",
  -- },
}
