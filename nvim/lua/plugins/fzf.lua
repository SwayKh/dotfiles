return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  -- optional for icon support
  dependencies = { "echasnovski/mini.nvim" },
  config = function()
    local fzf = require("fzf-lua")

    local config = require("fzf-lua.config")
    local t_actions = require("trouble.sources.fzf").actions
    config.defaults.actions.files["ctrl-t"] = t_actions.open

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
        row = 0.50, -- window row position (0=top, 1=bottom)
        col = 0.50, -- window col position (0=left, 1=right)
        preview = {
          layout = "horizontal",
          vertical = "down:50%",
          horizontal = "right:50%",
        },
      },
      keymap = {
        fzf = {
          ["alt-a"] = "toggle-all",
          ["ctrl-q"] = "select-all+accept",
        },
      },
      fzf_opts = {
        ["--layout"] = "default",
        ["--no-scrollbar"] = "",
        ["--header"] = " ",
        ["--marker"] = "+",
        -- ["--info"] = "inline", -- This puts the item count next to input
      },

      grep = {
        prompt = " Find ❯ ",
        rg_opts = [[--column --line-number --no-heading --color=always --hidden --smart-case --max-columns=4096 -e]],
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
        rg_opts = [[--color=never --files --no-ignore --hidden --follow -g "!.git"]],
        fd_opts = [[--color=never --type f --no-ignore --hidden --follow --exclude .git --ignore-file ~/home.gitignore]],
      },
      args = { prompt = " ❯ " },
      oldfiles = { prompt = " Recents ❯ " },
      buffers = { prompt = " Buffers ❯ ", no_header_i = true },
      colorschemes = { prompt = " Themes ❯ " },
      keymaps = { prompt = " Keymaps ❯ " },
      git = {
        files = { prompt = " Git Files ❯ " },
        status = { prompt = " ❯ " },
        commits = { prompt = " ❯ " },
      },
      helptags = {
        prompt = ":",
        -- preview_opts = "hidden",
        winopts = {
          row = 1,
          -- width = vim.api.nvim_win_get_width(0),
          width = 1,
          height = 0.4,
        },
      },
    })

    vim.keymap.set("n", "<leader>gf", fzf.git_files, { silent = true, desc = "Search [G]it [F]iles" }) --git_files
    vim.keymap.set("n", "<leader>s?", fzf.oldfiles, { silent = true, desc = "[S]earch Recent Files" })
    vim.keymap.set("n", "<leader>sf", fzf.files, { silent = true, desc = "[S]earch [F]iles" }) --find_files
    vim.keymap.set("n", "<leader>sg", fzf.live_grep, { silent = true, desc = "[S]earch by [G]rep" }) --live_grep
    vim.keymap.set("n", "<leader>sh", fzf.help_tags, { silent = true, desc = "[S]earch [H]elp" }) --help_tags
    vim.keymap.set("n", "<leader>gw", fzf.grep_cWORD, { silent = true, desc = "[G]rep current [W]ord" }) --grep_string
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
  end,
}
