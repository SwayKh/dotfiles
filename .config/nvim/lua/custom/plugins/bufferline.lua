return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        -- diagnostics = 'coc',
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    })
  end,
}
