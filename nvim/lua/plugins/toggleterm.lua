return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-,>", "<Cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>th", "<Cmd>ToggleTerm direction=horizontal <CR>", desc = "[T]oggleTerm [H]orizontal" },
    { "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", desc = "[T]oggleTerm [F]loat" },
    { "<leader>tv", "<Cmd>ToggleTerm direction=vertical<CR>", desc = "[T]oggleTerm [V]ertical" },
  },
  config = function()
    require("toggleterm").setup({
      size = 15,
      shade_filetypes = {},
      open_mapping = [[<c-,>]],
      shade_terminal = true,
      shading_factor = -50,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      autochdir = true,
      float_opts = { border = "none" },
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
    })
  end,
}
