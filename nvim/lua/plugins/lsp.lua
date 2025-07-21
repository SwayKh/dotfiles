local servers = {
  "bashls", -- Bash
  "clangd", -- C/C++
  "gopls", -- Golang
  "lua_ls", -- Lua
  "pyright", -- Python
  -- Web Dev LSPs
  "cssls", -- CSS
  "emmet_language_server", -- HTML
  "tailwindcss", -- Tailwind
  "ts_ls", -- Typescript/javascript
}

vim.lsp.enable(servers)

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
  root_markers = { ".git" },
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = true,
})

require("lazydev").setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  float = {
    source = "if_many",
    focusable = true,
    style = "minimal",
    border = vim.g.border_style,
  },
  signs = {
    priority = 300,
    text = {
      [vim.diagnostic.severity.ERROR] = " ", -- 󰅚
      [vim.diagnostic.severity.WARN] = " ", -- 󰀪
      [vim.diagnostic.severity.INFO] = " ", -- 󰋽
      [vim.diagnostic.severity.HINT] = "󰠠 ", -- 󰌶
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    prefix = "",
  },
  virtual_lines = {
    current_line = true,
    severity = vim.diagnostic.severity.ERROR,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
    map("grs", ":LspRestart<CR>", "LSP [R]e[S]tart")
    map("grr", function()
      MiniExtra.pickers.lsp({ scope = "references" })
    end, "[G]oto [R]eferences")
    map("gri", function()
      MiniExtra.pickers.lsp({ scope = "implementation" })
    end, "[G]oto [I]mplementation")
    map("grd", function()
      MiniExtra.pickers.lsp({ scope = "definition" })
    end, "[G]oto [D]definition")
    map("grD", function()
      MiniExtra.pickers.lsp({ scope = "declaration" })
    end, "[G]oto [D]eclaration")
    map("grt", function()
      MiniExtra.pickers.lsp({ scope = "type_definition" })
    end, "Type [D]definition")
    map("gO", function()
      MiniExtra.pickers.lsp({ scope = "document_symbol" })
    end, "[D]ocument [S]symbols")
    map("gW", function()
      MiniExtra.pickers.lsp({ scope = "workspace_symbol" })
    end, "[W]orkspace [S]symbols")

    -- Diagnostic keymaps
    map("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
    map("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

    -- Lesser used LSP functionality
    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    map("<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
  end,
})
