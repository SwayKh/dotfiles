return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- "${3rd}/luv/library",
        },
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
}
