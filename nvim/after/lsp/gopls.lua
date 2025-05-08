-- Golang
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
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
})
