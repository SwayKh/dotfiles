return {
  -- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  -- See `:help lualine.txt`
  -- Eviline config for lualine
  -- Author: shadmansaleh
  -- Credit: glepnir
  config = function()
    local lualine = require("lualine")

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
                bg       = '#202328',
                fg       = '#bbc2cf',
                yellow   = '#ECBE7B',
                cyan     = '#008080',
                darkblue = '#081633',
                green    = '#98be65',
                orange   = '#FF8800',
                violet   = '#a9a1e1',
                magenta  = '#c678dd',
                blue     = '#51afef',
                red      = '#ec5f67',
                white    = '#ffffff',
                black    = '#333333',
                gray     = '#424450',
        }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        icons_enabled = true,
        -- Disable sections and component separators
        -- component_separators = { left = "", right = "" },
        component_separators = "",
        section_separators = "",
        theme = "dracula",
        -- theme = {
        --   -- We are going to use lualine_c an lualine_x as left and
        --   -- right section. Both are highlighted by c theme .  So we
        --   -- are just setting default looks o statusline
        --   normal = { c = { fg = colors.fg, bg = colors.bg } },
        --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
        -- },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ins_left({
    --   function()
    --     return "▊"
    --   end,
    --   color = { fg = colors.blue }, -- Sets highlighting of component
    --   padding = { right = 0 },
    -- })

    -- ins_left({
    --   mode component
    --   padding = { right = 1 },
    --   function()
    --     return "󰣇"
    --   end,
    -- 
    -- 
    -- 
    -- })

    ins_left({
      "mode",
      icon = "",
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = colors.gray, bg = mode_color[vim.fn.mode()], gui = "bold" }
      end,
      padding = { left = 0, right = 1 },
      separator = { left = "", right = "" },
    })

    ins_left({
      function()
        -- Get the relative path of the current file
        local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":h")

        -- Get the file name of the current file
        local file_name = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")

        -- Concatenate the directory and file name
        local full_path = relative_path .. "/" .. file_name
        return full_path

        -- return vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")
        -- return vim.api.nvim_buf_get_name(0) --same as '%:p'
        -- return vim.fn.expand("%:p") -- fullpath
        -- return vim.fn.expand('%') --equivalent of @% in vimscript
        -- return vim.fn.getcwd()
      end,
      icons_enabled = true,
      cond = conditions.buffer_not_empty,
      color = { fg = colors.gray, bg = colors.yellow, gui = "bold" },
      padding = { left = 1, right = 1 },
      separator = { right = "" },
    })

    -- ins_left({
    --   "filename",
    --   cond = conditions.buffer_not_empty,
    --   color = { fg = colors.magenta, gui = "bold" },
    --   padding = { left = 1, right = 1 },
    -- })

    ins_left({
      "filesize",
      icons_enabled = true,
      cond = conditions.buffer_not_empty,
      color = { fg = colors.gray, bg = colors.green, gui = "bold" },
      separator = { right = "" },
      padding = { left = 1, right = 1 },
    })

    ins_left({
      "diagnostics",
      icons_enabled = true,
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
      padding = { left = 1, right = 1 },
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @" .. recording_register
      end
    end

    ins_right({
      "macro-recording",
      icons_enabled = true,
      fmt = show_macro_recording,
      color = { fg = colors.fg, gui = "bold" },
      padding = { left = 1, right = 1 },
    })

    ins_right({
      "diff",
      icons_enabled = true,
      -- Is it me or the symbol for modified us really weird
      symbols = { added = " ", modified = "󰜥 ", removed = " " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
      padding = { left = 1, right = 1 },
    })

    ins_right({
      "location",
      icons_enabled = true,
      color = { fg = colors.gray, bg = colors.fg, gui = "bold" },
      separator = { left = "" },
      padding = { left = 1, right = 1 },
    })

    ins_right({
      "progress",
      icons_enabled = true,
      color = { fg = colors.gray, bg = colors.violet, gui = "bold" },
      separator = { left = "" },
      padding = { left = 1, right = 1 },
    })

    -- Add components to right sections
    ins_right({
      "o:encoding", -- option component same as &encoding in viml
      icons_enabled = true,
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.gray, bg = colors.magenta, gui = "bold" },
      padding = { left = 1, right = 1 },
      separator = { left = "" },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.gray, bg = colors.yellow, gui = "bold" },
      padding = { left = 1, right = 1 },
      separator = { left = "" },
    })

    ins_right({
      "branch",
      icon = "",
      icons_enabled = true,
      color = { fg = colors.gray, bg = colors.green, gui = "bold" },
      padding = { left = 1, right = 1 },
      separator = { left = "" },
    })

    ins_right({
      -- Lsp server name .
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = " LSP:",
      color = { fg = colors.gray, bg = colors.white, gui = "bold" },

      padding = { left = 1, right = 1 },
      separator = { left = "", right = "" },
    })

    -- ins_right({
    --   function()
    --     return "▊"
    --   end,
    --   color = { fg = colors.blue },
    --   padding = { left = 0 },
    --   component_separators = { left = "" },
    -- })

    -- Separaters
    --   ▊     ▊  

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
