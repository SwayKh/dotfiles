return {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=none",
    "--function-arg-placeholders=false",
  },
  filetypes = { "c", "cpp" },
  root_markers = { ".clangd" },
}
