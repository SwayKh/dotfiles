return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = false,
          transparency = false,
          terminal_colors = true,
          highlight_inactive_windows = false,
        },
        highlights = {
          Comment = { italic = true },
          Directory = { bold = true },
          ErrorMsg = { italic = true, bold = true },
        },
        styles = {
          comments = "italic",
          keywords = "bold,italic",
          functions = "bold",
          strings = "altfont",
          variables = "NONE",
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          constants = "italic",
          operators = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
        filetypes = {
          all = true,
        },
      })
      vim.cmd.colorscheme("onedark")
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
  --   "navarasu/onedark.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("onedark").setup({
  --       style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  --       transparent = false, -- Show/hide background
  --       term_colors = true, -- Change terminal color as per the selected theme style
  --
  --       -- toggle theme style ---
  --       toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  --       toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
  --
  --       -- Options are italic, bold, underline, none
  --       code_style = {
  --         comments = "italic",
  --         keywords = "bold,italic",
  --         functions = "bold",
  --         strings = "none",
  --         variables = "none",
  --       },
  --       -- Plugins Config --
  --       diagnostics = {
  --         darker = false, -- darker colors for diagnostic
  --         undercurl = true, -- use undercurl instead of underline for diagnostics
  --         background = true, -- use background color for virtual text
  --       },
  --     })
  --     vim.cmd.colorscheme("onedark")
  --   end,
  -- },
  -- {
  --   "ray-x/starry.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("starry").setup({
  --       border = true, -- Split window borders
  --       hide_eob = false, -- Hide end of buffer
  --       italics = {
  --         comments = true, -- Italic comments
  --       },
  --       -- other themes: earlysummer, darker, darksolar, deepocean, dracula,
  --       -- dracula_blood, emerald, limestone, mariana, mariana_lighter,
  --       -- moonlight, oceanic, monokai, palenight, starry, ukraine
  --     })
  --     vim.cmd.colorscheme("earlysummer")
  --   end,
  -- },
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
  --   priority = 1000,
  --   config = function()
  --     require("nightfox").setup({
  --       options = {
  --         styles = {
  --           comments = "italic",
  --           keywords = "bold",
  --           types = "italic,bold",
  --           strings = "altfont",
  --           -- variables = "standout", // Highlights the whole word
  --         },
  --         transparent = false, -- Disable setting background
  --         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
  --         dim_inactive = true, -- Non focused panes set to alternative background
  --         module_default = true, -- Default enable value for modules
  --       },
  --     })
  --     vim.cmd.colorscheme("terafox")
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
