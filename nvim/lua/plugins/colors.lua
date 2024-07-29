return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        transparent = true,
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })

      vim.cmd.colorscheme("carbonfox")
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
      -- vim.cmd.hi("Comment gui=none")
      -- vim.cmd.hi("Normal guibg=#222222")
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
  },
  -- {
  --   "marko-cerovac/material.nvim",
  -- },
  -- {
  --   "dasupradyumna/midnight.nvim",
  -- },
  -- {
  --   "eldritch-theme/eldritch.nvim",
  -- },
  -- {
  --   "sainnhe/sonokai",
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  -- },
  -- {
  --   "sainnhe/edge",
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
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
