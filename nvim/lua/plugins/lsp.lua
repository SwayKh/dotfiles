local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

require("lazydev").setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

require("lspconfig.ui.windows").default_options.border = vim.g.border_style

vim.diagnostic.config({
  severity_sort = true,
  float = {
    source = "if_many",
    focusable = true,
    style = "minimal",
    border = vim.g.border_style,
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font
      and {
        text = {
          [vim.diagnostic.severity.ERROR] = " ", -- 󰅚
          [vim.diagnostic.severity.WARN] = " ", -- 󰀪
          [vim.diagnostic.severity.INFO] = " ", -- 󰋽
          [vim.diagnostic.severity.HINT] = "󰠠 ", -- 󰌶
        },
      }
    or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<leader>rs", ":LspRestart<CR>", "LSP [R]e[S]tart")

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

    -- See `:help K` for why this keymap
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- Diagnostic keymaps
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
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
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
      group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
      end,
    })
  end,
})

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
-- local mason_tool_installer = require("mason-tool-installer")

local servers = {
  emmet_language_server = {}, -- HTML
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

mason.setup({
  ui = {
    border = vim.g.border_style,
    width = 0.8,
    height = 0.8,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities))

mason_lspconfig.setup({
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      lspconfig[server_name].setup(server)
    end,
  },
})
