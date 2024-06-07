return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    fzf.setup({
      "fzf-native", -- profiles, options {"default", "telescope", "fzf-native", "fzf-tmux", "fzf-vim"} + :fzflua profiles
      preview = { layout = "horizontal" },
      winopts = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- On by default
        -- border = { "none", "single", "double", "rounded", "solid", "shadow" },
        title = " Fzf ",
        title_pos = "center",
        height = 0.80, -- window height
        width = 0.80, -- window width
        row = 0.45, -- window row position (0=top, 1=bottom)
        col = 0.50, -- window col position (0=left, 1=right)
        preview = {
          layout = "horizontal",
          vertical = "down:50%",
          horizontal = "right:50%",
        },
      },
      keymap = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- delete or modify is sufficient
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["ctrl-q"] = "select-all+accept",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      actions = {
        files = {
          ["default"] = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-l"] = actions.file_sel_to_ll,
        },
        buffers = {
          ["default"] = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },
      fzf_opts = {
        ["--layout"] = "default",
        ["--no-scrollbar"] = "",
        ["--header"] = " ",
        ["--marker"] = "+",
        -- ["--info"] = "inline", -- This puts the item count next to input
      },

      args = { prompt = " ❯ " },
      oldfiles = { prompt = " Recents ❯ " },
      buffers = { prompt = " Buffers ❯ ", no_header_i = true },
      colorschemes = { prompt = " Themes ❯ " },
      keymaps = { prompt = " Keymaps ❯ " },
      grep = {
        prompt = " Find ❯ ",
        no_header_i = true,
        rg_glob = true, -- enable glob parsing by default to all
        -- grep providers? (default:false)
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      },
      files = {
        prompt = " Files ❯ ",
        no_header_i = true,
        cwd_prompt = false,
        git_icons = true,
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git --ignore-file ~/.gitignore]],
      },
      git = {
        files = { prompt = " Git Files ❯ " },
        status = { prompt = " ❯ " },
        commits = { prompt = " ❯ " },
      },
      helptags = {
        prompt = ":",
        preview_opts = "hidden",
        winopts = {
          row = 1,
          width = vim.api.nvim_win_get_width(0),
          height = 0.4,
        },
      },
    })

    vim.keymap.set("n", "<leader>gf", fzf.git_files, { silent = true, desc = "Search [G]it [F]iles" }) --git_files
    vim.keymap.set("n", "<leader>s?", fzf.oldfiles, { silent = true, desc = "[S]earch Recent Files" })
    vim.keymap.set("n", "<leader>sf", fzf.files, { silent = true, desc = "[S]earch [F]iles" }) --find_files
    vim.keymap.set("n", "<leader>sg", fzf.live_grep, { silent = true, desc = "[S]earch by [G]rep" }) --live_grep
    vim.keymap.set("n", "<leader>sh", fzf.help_tags, { silent = true, desc = "[S]earch [H]elp" }) --help_tags
    vim.keymap.set("n", "<leader>sw", fzf.grep_cWORD, { silent = true, desc = "[S]earch current [W]ord" }) --grep_string
    vim.keymap.set("n", "<leader>sr", fzf.resume, { silent = true, desc = "[S]earch [R]esume" }) --resume
    vim.keymap.set("n", "<leader>sk", fzf.keymaps, { silent = true, desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sb", fzf.builtin, { silent = true, desc = "[S]earch [B]uiltin FzfLua commands" })
    vim.keymap.set("n", "<leader>st", fzf.colorschemes, { silent = true, desc = "[S]earch [T]hemes/Colorscheme" })
    vim.keymap.set("n", "<leader>sc", fzf.commands, { silent = true, desc = "[S]earch [C]ommands" })
    vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, { silent = true, desc = "[S]earch [D]iagnostics" }) --diagnostics

    vim.keymap.set("n", "<leader><leader>", fzf.buffers, { silent = true, desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>sn", function()
      require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
    end, { silent = true, desc = "[S]earch [N]vim config" })

    vim.keymap.set("n", "<leader>s.", function()
      require("fzf-lua").files({ cwd = "$HOME/dotfiles" })
    end, { silent = true, desc = "[S]earch [N]vim config" })

    vim.keymap.set("n", "<leader>s/", function()
      require("fzf-lua").grep_curbuf({
        fzf_opts = {
          ["--layout"] = "reverse",
        },
        winopts = {
          title = " Grep Buffer ",
          title_pos = "center",
          preview = { hidden = "hidden" },
          height = 0.40, -- window height
          width = vim.api.nvim_win_get_width(0),
          row = 1, -- window row position (0=top, 1=bottom)
        },
      })
    end, { desc = "[S]earch [/] in current buffer" })

    vim.keymap.set("n", "<leader>lr", function()
      fzf.fzf_exec(require("config.utils").pluginNames(), {
        prompt = "Select a plugin > ",
        actions = {
          ["default"] = function(selected)
            vim.cmd("Lazy reload " .. selected[1])
          end,
        },
        winopts = {
          title = " Reload Plugins ",
          title_pos = "center",
          preview = { hidden = "hidden" },
          height = 0.50, -- window height
          width = 0.40, -- window width
          row = 0.50, -- window row position (0=top, 1=bottom)
          col = 0.50, -- window col position (0=left, 1=right)
        },
      })
    end, { desc = "[L]azy [R]eload plugin of choice" })

    --[[telescope.lua
    -- Consutomize the look (Done)
    -- Search bar as separate window (No Need the Native theme is better)
    -- bigger fzf list or equal size to preview (Don't even know that this is)
    -- harpoon is using telescope, DO SOMETHING (Remove Telescope from harpoon
    -- and then remove harpoon too)
    -- Remove all telescope mentions from keybinds and configs (Done)
    -- So many open tabs (It's all in the past now)
    -- look into silent keybinds, that don't show cmd when running (Done, Also
    -- for Alpha.nvim)
    -- telescope insert mode actions should be moved to fzf-lua (C-n/p better)
    -- Get better theme, Dracula looks bad with cmp border (Nightfox for now)
    -- Remove the ctrl+g ctrl+x key showing below prompt (Done, Needed to open
    -- an issue on github)
    -- Make the layout like one in fzflua command menu (It was the Native preset)
    -- alpha dashboard had keybinds to telescope remove them (Done)
    -- create a keybind to pick a plugin and lazy reload it (Did this after many
    -- months, But it felt good to do. Also there was a easier way with
    -- lazy.plugins)
    --]]
  end,
}
