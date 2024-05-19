return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
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
      fzf_opts = {
        ["--layout"] = "default",
        ["--no-scrollbar"] = "",
        ["--header"] = " ",
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

    -- vim.keymap.set("n", "<leader>l", fzf.fzf_exec(require("lazy").plugins()), { desc = "Test commands" })

    --[[telescope.lua
    -- Consutomize the look
    -- Search bar as separate window
    -- bigger fzf list or equal size to preview
    -- harpoon is using telescope, DO SOMETHING
    -- Remove all telescope mentions from keybinds and configs
    -- So many open tabs
    -- look into silent keybinds, that don't show cmd when running
    -- telescope insert mode actions should be moved to fzf-lua
    -- Get better theme, Dracula looks bad with cmp border
    -- Remove the ctrl+g ctrl+x key showing below prompt
    -- Make the layout like one in fzflua command menu
    -- alpha dashboard had keybinds to telescope remove them
    -- create a keybind to pick a plugin and lazy reload it
    --]]
  end,
}
