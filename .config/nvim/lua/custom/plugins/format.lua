local prettier = { "prettierd", "prettier" }

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "=",
      function()
        require("conform").format({ async = true, lsp_fallback = true }, function(err)
          if not err then
            if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { prettier },
      typescript = { prettier },
      javascriptreact = { prettier },
      typescriptreact = { prettier },
      css = { prettier },
      html = { prettier },
      json = { prettier },
      jsonc = { prettier },
      yaml = { prettier },
      markdown = { prettier, "injected" },
      norg = { "injected" },
      graphql = { prettier },
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      zig = { "zigfmt" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
      ["*"] = { "codespell" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      -- Dealing with old version of prettierd that doesn't support range formatting
      prettierd = {
        range_args = false,
      },
    },
    log_level = vim.log.levels.TRACE,
    format_after_save = { timeout_ms = 5000, lsp_fallback = true },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    if vim.g.started_by_firenvim then
      opts.format_on_save = false
      opts.format_after_save = false
    end
    require("conform").setup(opts)
  end,
}
