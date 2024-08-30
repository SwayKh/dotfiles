return {
  {
    "dracula/vim",
    name = "dracula",
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent = false,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "bold,italic",
        },
      })
      vim.cmd.colorscheme("dracula")
    end,
    vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" }),
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" }),
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" }),
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" }),
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" }),
    -- vim.cmd.hi("Comment gui=none"),
    -- vim.cmd.hi("Normal guibg=#222222"),
  },
  -- {
  --   "sainnhe/everforest",
  --   priority = 1000,
  --   config = function()
  --     -- " Available values: 'hard', 'medium'(default), 'soft'
  --     vim.g.everforest_background = "hard"
  --     vim.g.everforest_enable_italic = 1
  --     vim.g.everforest_ui_contrast = "high"
  --     vim.g.everforest_diagnostic_text_highlight = 1
  --     vim.g.everforest_better_performance = 1
  --     vim.cmd.colorscheme("everforest")
  --   end,
  -- },
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
  --   priority = 1000,
  --   config = function()
  --     require("dracula").setup({
  --       transparent = false,
  --       styles = {
  --         comments = "italic",
  --         keywords = "bold",
  --         types = "bold,italic",
  --       },
  --     })
  --     vim.cmd.colorscheme("dracula")
  --   end,
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
