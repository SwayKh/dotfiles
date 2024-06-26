return {
  "mbbill/undotree",
  event = "VeryLazy",
  cmd = "UndotreeToggle",
  vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>", { silent = true, desc = "Open undo tree" }),
}
