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

require("config.option")
require("config.globals")
require("config.autocmd")
require("config.keybinds")

local function arrow()
  add({
    source = "otavioschwanck/arrow.nvim",
  })
  require("plugins.arrow")
end

local function blink()
  add({
    source = "Saghen/blink.cmp",
    checkout = "v1.3.1",
    depends = {
      "rafamadriz/friendly-snippets",
    },
  })
  require("plugins.blink")
end

local function colorscheme()
  -- Nice default color scheme:
  -- default, habamax, retrobox, sorbet, wildcharm, unokai, slate
  vim.cmd.colorscheme("slate")
end

local function formatter()
  add({
    source = "stevearc/conform.nvim",
  })
  require("plugins.format")
end

local function hardtime()
  add({
    source = "m4xshen/hardtime.nvim",
    depends = {
      "MunifTanjim/nui.nvim",
    },
  })
  require("hardtime").setup({
    max_time = 1000,
    max_count = 3,
    disable_mouse = true,
    hint = true,
    timeout = 3000,
    notification = true,
    allow_different_key = true,
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
    source = "mason-org/mason.nvim",
    depends = {
      "mason-org/mason-lspconfig.nvim",
      "nvim-lua/plenary.nvim",
      "folke/lazydev.nvim",
      -- "neovim/nvim-lspconfig",
      -- "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  })

  require("plugins.lsp")
  vim.cmd("LspStart")
end

local function markdown()
  add({
    source = "OXY2DEV/markview.nvim",
  })

  local presets = require("markview.presets")
  require("markview").setup({
    markdown = {
      headings = presets.headings.arrowed,
      horizontal_rules = presets.horizontal_rules.thick,
      tables = presets.tables.rounded,
    },
    preview = {
      icon_provider = "mini", -- "mini" or "devicons"
    },
  })
  -- Do not close the preview tab when switching to other buffers
  vim.keymap.set("n", "<leader>mp", ":Markview<CR>", { desc = "Preview Markdown" })
end

local function mini_plugins()
  add({
    source = "echasnovski/mini.nvim",
  })
  require("plugins.mini")
end

local function snacks()
  add({
    source = "folke/snacks.nvim",
  })
  require("plugins.snacks")
end

local function treesitter()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    -- monitor = "main",
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
  colorscheme()
  mini_plugins()
  snacks()
end)

later(function()
  arrow()
  blink()
  formatter()
  hardtime()
  linter()
  lsp()
  markdown()
  treesitter()
  trouble()

  -- add vim-startuptime plugin
  add({
    source = "dstein64/vim-startuptime",
  })
end)
