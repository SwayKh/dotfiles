return {
  "williamboman/mason.nvim",
  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" },
  -- event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        border = "double",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- LSP
        "bashls", -- Bash
        "clangd", -- C/C++
        "gopls", -- Golang
        "pyright", -- Python
        "lua_ls", -- Lua
        "html", -- HTML
        "htmx", -- HTMX
        "emmet_language_server", -- HTML
        "cssls", -- CSS
        "tailwindcss", -- Tailwind CSS
        "tsserver", -- Javascript, TypeScript
        "eslint", -- React/NextJS/Svelte
        -- "biome", -- Json, and JS
        "marksman", -- Markdown lsp
        "sqlls", -- SQL
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- { "bash-language-server" },
        -- FORMATTERS
        { "gofumpt" }, -- GO
        { "goimports" }, -- GO
        { "black" }, -- Python
        { "isort" }, -- Python
        { "prettierd" }, -- JS and Many More
        { "shfmt" }, -- Shell Script
        { "stylua" }, -- Lua

        -- LINTERS
        { "codespell" },
        -- { "eslint_d" },
        { "pylint" },
        { "shellcheck" },

        --DAP
        { "delve" },
        { "debugpy" },
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
    })
  end,
}
