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
        "bash_ls", -- Bash
        "clangd", -- C/C++
        "gopls", -- Golang
        "pyright", -- Python
        "lua_ls", -- Lua
        "html", -- HTML
        "htmx", -- HTMX
        "emmet_ls", -- HTML
        "cssls", -- CSS
        "tsserver", -- Javascript, TypeScript
        "biome", -- Json, and JS
        "marksman", -- Markdown lsp
        "sqlls", -- SQL
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })
    require("neodev").setup()

    local servers = {
      -- clangd = {},
      gopls = {},
      pyright = {},
      -- rust_analyzer = {},
      -- tsserver = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = {
            disable = { "missing-fields" },
          },
        },
      },
    }

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- mason_lspconfig.setup_handlers({
    --   function(server_name)
    --     require("lspconfig")[server_name].setup({
    --       capabilities = capabilities,
    --       on_attach = on_attach,
    --       settings = servers[server_name],
    --       filetypes = (servers[server_name] or {}).filetypes,
    --     })
    --   end,
    -- })
  end,
}

--
-- Linter
-- ◍ codespell
-- ◍ djlint
-- ◍ shellcheck
--
-- Formatter
-- ◍ black
-- ◍ djlint
-- ◍ gofumpt
-- ◍ goimports
-- ◍ isort
-- ◍ prettier
-- ◍ shfmt
-- ◍ stylua
