return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { ".git", "go.mod", "go.work" },
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
