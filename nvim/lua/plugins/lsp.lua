return {
  -- Going to copy over kickstart nvim lsp config
  -- Will have Mason, Mason-tool-installer and nvim_lspconfig all in one place
  --
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",

  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" },
  event = { "BufReadPost" },
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "j-hui/fidget.nvim",
    "hrsh7th/cmp-nvim-lsp", -- for autocompletion
    { "antosha417/nvim-lsp-file-operations", config = true },
    "folke/neodev.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local util = require("lspconfig.util")
    local lspui = require("lspconfig.ui.windows")

    require("neodev").setup()
    lspui.default_options.border = "rounded"

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>rs", ":LspRestart", "LSP [R]e[S]tart")

        map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        map("gi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
        map("gD", require("fzf-lua").lsp_declarations, "[G]oto [D]eclaration")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]symbols")
        map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]symbols")

        -- See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        -- map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Diagnostic keymaps
        -- Don't need these right now
        map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
        map("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
        map("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
        map("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

        -- Lesser used LSP functionality
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

    local servers = {
      bashls = {}, -- Bash
      clangd = {}, -- C/C++
      cssls = {}, -- CSS
      marksman = {}, -- Markdown lsp
      sqlls = {}, -- SQL
      -- eslint = {},   -- React/NextJS/Svelte
      emmet_language_server = {
        filetypes = { "html", "twig", "hbs" },
      }, -- HTML
      tsserver = { -- Javascript, TypeScript
        filetypes = { "javascript", "typescriptreact", "javascriptreact", "svelte" },
      },
      -- html = { -- HTML
      --   filetypes = { "html", "twig", "hbs" },
      -- },
      -- htmx = {}, -- HTMX
      -- tailwindcss = {
      --   filetypes = { "html", "twig", "hbs" },
      -- }, -- Tailwind CSS
      gopls = { -- Golang
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      },
      pyright = { -- Python
        filetypes = { "python" },
      },
      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              -- library = {
              --   "${3rd}/luv/library",
              --   unpack(vim.api.nvim_get_runtime_file("", true)),
              -- },
              -- If lua_ls is really slow on your computer, you can try this instead:
              library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            },
          },
        },
      },
    }

    local border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    mason.setup({
      ui = {
        border = "rounded",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
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
    })
    mason_tool_installer.setup({
      ensure_installed = ensure_installed,

      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
    })

    -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    --   opts = opts or {}
    --   opts.border = opts.border or border
    --   return orig_util_open_floating_preview(contents, syntax, opts, ...)
    -- end

    mason_lspconfig.setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          lspconfig[server_name].setup(server)
        end,
      },
    })
  end,
}
