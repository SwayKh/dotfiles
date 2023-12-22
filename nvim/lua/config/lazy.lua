local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.lsp" },
}, {
  ui = {
    border = "double",
    size = {
      width = 0.8,
      height = 0.8,
    },
  },

  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
