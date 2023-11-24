return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    local markdown = require("markdown-preview")
    markdown.setup({
      vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>"),
    })
  end,
}
