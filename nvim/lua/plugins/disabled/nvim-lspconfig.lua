return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "folke/neodev.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local util = require("lspconfig.util")
    -- local lspui = require("lspconfig.ui.windows")

    require("neodev").setup()
    -- lspui.default_options.border = "double"

    -- [[ Configure LSP ]]
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      nmap("<leader>rs", ":LspRestart", "LSP [R]e[S]tart")

      nmap("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
      nmap("gi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
      nmap("gD", require("fzf-lua").declarations, "[G]oto [D]eclaration")
      nmap("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
      nmap("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]symbols")
      nmap("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]symbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Diagnostic keymaps
      -- Don't need these right now
      nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
      nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
      nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
      nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

      -- Lesser used LSP functionality
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          -- settings = servers[server_name],
          -- filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "twig", "hbs" },
    })
    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- configure emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "typescriptreact", "javascriptreact", "svelte" },
    })

    lspconfig["eslint"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "python" },
    })
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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
    })
    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            disable = { "missing-fields" },
          },
          telemetry = { enable = false },
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            -- Tells lua_ls where to find all the Lua files that you have loaded
            -- for your neovim configuration.
            library = {
              "${3rd}/luv/library",
              unpack(vim.api.nvim_get_runtime_file("", true)),
            },
            -- If lua_ls is really slow on your computer, you can try this instead:
            -- library = { vim.env.VIMRUNTIME },
          },
          completion = {
            callSnippet = "Replace",
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    })
  end,
}
