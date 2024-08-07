return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  -- event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function()
    require("alpha").setup(require("alpha.themes.dashboard").config)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
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
      dashboard.button("n", "  > New file", "<Cmd>ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰱼  > Find file", "<Cmd>FzfLua files<CR>"),
      dashboard.button("r", "  > Recent", "<Cmd>FzfLua oldfiles<CR>"),
      dashboard.button("e", "  > File Tree", "<Cmd>Oil<CR>"),
      dashboard.button("s", "  > Settings", "<Cmd>FzfLua files cwd=~/.config/nvim/<CR>"),
      dashboard.button("l", "󰒲  > Lazy", "<Cmd>Lazy<CR>"),
      dashboard.button("q", "  > Quit NVIM", "<Cmd>qa<CR>"),
    }
    -- local fortune = require("alpha.fortune")
    -- dashboard.section.footer.val = fortune()

    dashboard.section.footer.val = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
    end

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])
  end,
}
