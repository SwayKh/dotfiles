return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
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
        "bash_ls", -- Bash
        "clangd", -- C/C++
        "gopls", -- Golang
        "pyright", -- Python
        "lua_ls", -- Lua
        "html", -- HTML
        "emmet_ls", -- HTML
        "cssls", -- CSS
        "tsserver", -- Javascript, TypeScript
        "biome", -- Json, and JS
        "marksman", -- Markdown lsp
        "sqlls", -- SQL

        -- FORMATTERS
        "black",
        "djlint",
        "gofumpt",
        "goimports",
        "isort",
        "prettier",
        "shfmt",
        "stylua",

        -- LINTERS
        "codespell",
        "shellcheck",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
  end,
}
