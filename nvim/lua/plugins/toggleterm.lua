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

vim.keymap.set(
  "n",
  "<leader>th",
  "<Cmd>ToggleTerm direction=horizontal <CR>",
  { silent = true, desc = "[T]oggleTerm [H]orizontal" }
)
vim.keymap.set(
  "n",
  "<leader>tf",
  "<Cmd>ToggleTerm direction=float<CR>",
  { silent = true, desc = "[T]oggleTerm [F]loat" }
)
vim.keymap.set(
  "n",
  "<leader>tv",
  "<Cmd>ToggleTerm size=60 direction=vertical<CR>",
  { silent = true, desc = "[T]oggleTerm [V]ertical" }
)

return {}
