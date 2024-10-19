return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  keys = {
    { "<leader>mp", ":MarkdownPreview<CR>", desc = "Preview Markdown" },
  },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
