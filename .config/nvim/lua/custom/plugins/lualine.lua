return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = { left = '•', right = '•' }, --  ·•
      section_separators = { left = '', right = '' }, -- 
    },
  },
}
