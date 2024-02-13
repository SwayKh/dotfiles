return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("alpha").setup(require("alpha.themes.dashboard").config)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    -- dashboard.section.header.val = {
    --   "                                                     ",
    --   "                                                     ",
    --   "                                                     ",
    --   "                                                     ",
    --   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    --   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    --   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    --   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    --   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    --   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    --   "                                                     ",
    --   "                                                     ",
    -- }
    dashboard.section.header.val = {
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("n", " > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰱼  > Find file", ":FzfLua files<CR>"),
      dashboard.button("r", "  > Recent", ":FzfLua oldfiles<CR>"),
      dashboard.button("e", "  > File Tree", ":Oil<CR>"),
      dashboard.button("s", "  > Settings", ":Oil ~/dotfiles/nvim/<CR> "),
      dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
    }
    local fortune = require("alpha.fortune")
    dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])
  end,
}
