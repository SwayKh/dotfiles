return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('alpha').setup(require('alpha.themes.dashboard').config)
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set header
    dashboard.section.header.val = {
      '                                                     ',
      '                                                     ',
      '                                                     ',
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
      '                                                     ',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('e', ' > New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('/', '󰱼  > Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
      dashboard.button('f', '  > File Tree', ':NvimTreeToggle<CR>'),
      dashboard.button('s', '  > Settings', ':e ~/.config/nvim/init.lua<CR>'),
      dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
    }
    local fortune = require 'alpha.fortune'
    dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[
            autocmd FileType alpha setlocal nofoldenable
        ]]
  end,
}
