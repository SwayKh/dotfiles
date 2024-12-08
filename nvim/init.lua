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

local function blink()
  add({
    source = "Saghen/blink.cmp",
    checkout = "v0.7.1",
    depends = {
      "rafamadriz/friendly-snippets",
    },
  })
  require("plugins.blink")
end

local function colorscheme()
  add({
    source = "rebelot/kanagawa.nvim",
  })
  require("kanagawa").setup({
    compile = false, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,
    -- Remove background color of sign column
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  })
  vim.cmd.colorscheme("kanagawa")

  -- vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  -- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
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
      "nvim-lua/plenary.nvim",
      "folke/lazydev.nvim",
    },
  })

  require("plugins.lsp")
  vim.cmd("LspStart")
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

local function vim_navigator()
  add({
    source = "christoomey/vim-tmux-navigator",
  })
end

-- Load everything now
now(function()
  require("config.option")
  colorscheme()
  snacks()
  mini_plugins()
end)

later(function()
  require("config.keybinds")
  require("config.autocmd")
  arrow()
  blink()
  -- debugger()
  formatter()
  linter()
  lsp()
  markdown_preview()
  treesitter()
  trouble()
  vim_navigator()

  -- -- add vim-startuptime plugin
  -- add({
  --   source = "dstein64/vim-startuptime",
  -- })
end)
