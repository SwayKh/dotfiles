vim.loader.enable()

-- Load everything now
require("config.globals")
require("config.option")
require("config.autocmd")
require("config.usercmd")
require("config.keybinds")

local function arrow()
  vim.pack.add({
    { src = "https://github.com/otavioschwanck/arrow.nvim" },
  })
  require("plugins.arrow")
end

local function blink()
  vim.pack.add({
    {
      src = "https://github.com/Saghen/blink.cmp",
      version = vim.version.range("^1"),
    },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
  })
  require("plugins.blink")
  require("config.utils").fixCmpHighlight() -- dify the kind icon hightlight colors
end

local function colorscheme()
  -- Nice default color scheme:
  -- default, habamax, retrobox, sorbet, wildcharm, unokai, slate, shint
  vim.cmd.colorscheme("habamax")
end

local function formatter()
  vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
  })
  require("plugins.format")
end

local function linter()
  vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint" },
  })
  require("plugins.lint")
end

local function lsp()
  vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },

    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    -- { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
  })

  require("plugins.lsp")
end

local function markdown()
  vim.pack.add({
    { src = "https://github.com/OXY2DEV/markview.nvim" },
  })
  require("plugins.markdown")
end

local function mini_plugins()
  vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
  })
  require("plugins.mini")
end

local function snacks()
  vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
  })
  require("plugins.snacks")
end

local function treesitter()
  vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
  }, { load = true })
  vim.schedule(function()
    require("plugins.treesitter")
  end)
end

local function trouble()
  vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim" },
  })
  require("plugins.trouble")
end

local function undotree()
  vim.cmd("packadd nvim.undotree")

  vim.cmd("packadd nvim.undotree")
  vim.keymap.set("n", "<leader>U", require("undotree").open, { desc = "Undotree" })
end

-- Load these now
colorscheme()
mini_plugins()
snacks()
-- Lazily Loading, kind of
vim.schedule(function()
  arrow()
  blink()
  formatter()
  linter()
  lsp()
  markdown()
  treesitter()
  trouble()
  undotree()

  vim.cmd("packadd nvim.difftool")
  -- New UI opt-in
  require("vim._core.ui2").enable()

  -- add vim-startuptime plugin
  -- vim.pack.add({
  --   { src = "https://github.com/dstein64/vim-startuptime" },
  -- })
end)
