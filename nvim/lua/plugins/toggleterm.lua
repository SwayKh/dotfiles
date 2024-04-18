return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  version = "*",
  opts = {--[[ things you want to change go here]]
  },
  config = function()
    require("toggleterm").setup({
      size = 10,
      shade_filetypes = {},
      open_mapping = [[<c-/>]],
      shade_terminal = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      autochdir = true,
      float_opts = { border = "rounded" },
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
    vim.keymap.set("n", "<leader>t", ":ToggleTerm <CR>", { silent = true, desc = "[T]oggleTerm [F]loating" })
    vim.keymap.set("n", "<leader>th", ":ToggleTerm <CR>", { silent = true, desc = "[T]oggleTerm [F]loating" })
    vim.keymap.set(
      "n",
      "<leader>tf",
      ":ToggleTerm direction=float<CR>",
      { silent = true, desc = "[T]oggleTerm [H]orizontal" }
    )
    vim.keymap.set(
      "n",
      "<leader>tv",
      ":ToggleTerm size=60 direction=vertical<CR>",
      { silent = true, desc = "[T]oggleTerm [V]ertical" }
    )
  end,
}
