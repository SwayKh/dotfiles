return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
}
