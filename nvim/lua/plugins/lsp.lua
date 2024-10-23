local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local util = require("lspconfig.util")
local lspui = require("lspconfig.ui.windows")

require("lazydev").setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})
lspui.default_options.border = "none"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>rs", ":LspRestart", "LSP [R]e[S]tart")

    map("gd", function()
      MiniExtra.pickers.lsp({ scope = "definition" })
    end, "[G]oto [D]definition")

    map("gr", function()
      MiniExtra.pickers.lsp({ scope = "references" })
    end, "[G]oto [R]eferences")

    map("gi", function()
      MiniExtra.pickers.lsp({ scope = "implementation" })
    end, "[G]oto [I]mplementation")

    map("gD", function()
      MiniExtra.pickers.lsp({ scope = "declaration" })
    end, "[G]oto [D]eclaration")

    map("<leader>D", function()
      MiniExtra.pickers.lsp({ scope = "type_definition" })
    end, "Type [D]definition")

    -- map("<leader>ds", function()
    --   MiniExtra.pickers.lsp({ scope = "document_symbol" })
    -- end, "[D]ocument [S]symbols")
    --
    -- map("<leader>ws", function()
    --   MiniExtra.pickers.lsp({ scope = "workspace_symbol" })
    -- end, "[W]orkspace [S]symbols")

    -- map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]definition")
    -- map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
    -- map("gi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
    -- map("gD", require("fzf-lua").lsp_declarations, "[G]oto [D]eclaration")
    -- map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]definition")
    --
    -- map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]symbols")
    -- map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]symbols")

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
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
      end,
    })

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(true, { event.buf })
      map("<leader>ti", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle [I]nlay Hints")
    end

    vim.diagnostic.config({
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = "" },
          { name = "DiagnosticSignWarn", text = "" },
          { name = "DiagnosticSignHint", text = "󰌶" },
          { name = "DiagnosticSignInfo", text = "" },
        },
      },
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "none",
        source = "always",
        header = "",
        prefix = "",
      },
    })
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
  -- bashls = {}, -- Bash
  clangd = {}, -- C/C++
  marksman = {}, -- Markdown lsp
  sqlls = {}, -- SQL
  eslint = {}, -- React/NextJS/Svelte
  emmet_language_server = {}, -- HTML
  ts_ls = {}, -- Javascript, TypeScript
  html = {}, -- HTML
  htmx = {}, -- HTMX
  cssls = {}, -- CSS
  tailwindcss = {}, -- Tailwind CSS
  templ = {}, -- Templ
  pyright = {}, -- Python
  gopls = { -- Golang
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        analyses = {
          unusedparams = true,
          unreachable = true,
        },
        -- report vulnerabilities
        vulncheck = "Imports",
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
          displayContext = 10,
          keywordSnippet = "Both",
        },
        diagnostics = {
          globals = { "vim" },
          disable = { "missing-fields", "undefined-global" },
        },
        codeLens = {
          enable = true,
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
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
    border = "none",
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
  { "prettier" }, -- JS and Many More
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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

mason_lspconfig.setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      lspconfig[server_name].setup(server)
    end,
  },
})

return {}
