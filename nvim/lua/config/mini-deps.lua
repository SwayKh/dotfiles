vim.loader.enable()

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local function arrow()
  add({
    source = "otavioschwanck/arrow.nvim",
  })

  require("plugins.arrow")
end

local function nvim_cmp()
  add({
    -- There's a fork of nvim-cmp for much better performance
    -- try it out sometime, Here's the PR https://github.com/hrsh7th/nvim-cmp/pull/1980
    -- "yioneko/nvim-cmp",
    -- branch = "perf",
    -- "hrsh7th/nvim-cmp",
    source = "hrsh7th/nvim-cmp",
    checkout = "perf",
    depends = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline", -- For cmdline suggestions
    },
  })

  require("plugins.cmp")
end

local function colorscheme()
  add({
    source = "sainnhe/everforest",
  })
  -- " Available values: 'hard', 'medium'(default), 'soft'
  vim.g.everforest_background = "hard"
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_ui_contrast = "high"
  vim.g.everforest_diagnostic_text_highlight = 1
  vim.g.everforest_diagnostic_line_highlight = 1
  vim.g.everforest_better_performance = 1
  vim.g.everforest_transparent_background = 2
  vim.g.everforest_float_style = "dim"
  vim.g.everforest_diagnostic_virtual_text = "colored"
  vim.g.everforest_dim_inactive_windows = 1
  vim.cmd.colorscheme("everforest")
end

local function debugger()
  add({
    source = "mfussenegger/nvim-dap",
    depends = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
  })

  require("plugins.debug")
end

local function formatter()
  add({
    source = "stevearc/conform.nvim",
  })

  require("plugins.format")
end

local function vim_navigator()
  add({
    source = "christoomey/vim-tmux-navigator",
  })
end

local function linter()
  add({
    source = "mfussenegger/nvim-lint",
  })

  require("plugins.lint")
end

local function lsp()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp", -- for autocompletion
      "nvim-lua/plenary.nvim",
      "folke/lazydev.nvim",
    },
  })

  require("plugins.lsp")
end

local function markdown_preview()
  local build = function()
    vim.fn["mkdp#util#install"]()
  end
  add({
    source = "iamcco/markdown-preview.nvim",
    hooks = {
      post_install = function()
        later(build)
      end,
      post_checkout = build,
    },
  })

  -- Do not close the preview tab when switching to other buffers
  vim.g.mkdp_auto_close = 0
  vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Preview Markdown" })
end

local function mini_plugins()
  add({
    source = "echasnovski/mini.nvim",
  })

  require("plugins.mini")
end

local function noice()
  add({
    source = "folke/noice.nvim",
    depends = {
      "MunifTanjim/nui.nvim",
    },
  })

  require("plugins.noice")
end

local function supermaven()
  add({
    source = "supermaven-inc/supermaven-nvim",
  })

  require("plugins.supermaven")
end

local function toggleterm()
  add({
    source = "akinsho/toggleterm.nvim",
  })

  require("plugins.toggleterm")
end

local function treesitter()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
    depends = {
      "windwp/nvim-ts-autotag",
    },
  })

  require("plugins.treesitter")
end

local function trouble()
  add({
    source = "folke/trouble.nvim",
  })

  require("plugins.trouble")
end

-- Load everything now
now(function()
  require("config.option")
  colorscheme()
  -- require("mini.starter").setup()
end)

later(function()
  require("config.keybinds")
  require("config.autocmd")
  arrow()
  -- debugger()
  formatter()
  linter()
  lsp()
  markdown_preview()
  mini_plugins()
  noice()
  nvim_cmp()
  supermaven()
  toggleterm()
  treesitter()
  trouble()
  vim_navigator()

  -- -- add vim-startuptime plugin
  -- add({
  --   source = "dstein64/vim-startuptime",
  -- })
end)
