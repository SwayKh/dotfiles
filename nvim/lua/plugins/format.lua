vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    html = { "djlint", "prettierd", "prettier" },
    templ = { "djlint", "templ" },
    json = { "prettierd", "prettier" },
    jsonc = { "prettierd", "prettier" },
    rasi = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier", "injected" },
    norg = { "injected" },
    graphql = { "prettierd", "prettier" },
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
    sh = { "beautysh", "shfmt" },
    python = { "isort", "ruff" },
    zig = { "zigfmt" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
    ["*"] = { "codespell" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
  log_level = vim.log.levels.TRACE,
  format_after_save = { timeout_ms = 500, lsp_fallback = true, async = true, quiet = true },
})
vim.keymap.set("n", "=", function()
  require("conform").format({ async = true, lsp_fallback = true }, function(err)
    if not err then
      if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format buffer" })
