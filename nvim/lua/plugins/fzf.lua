return {
  "ibhagwan/fzf-lua",
  keys = {
    {
      "<leader>gf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Search [G]it [F]iles",
    },
    {
      "<leader>s?",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "[S]earch Recent Files",
    },
    {
      "<leader>sf",
      function()
        require("fzf-lua").files()
      end,
      desc = "[S]earch [F]iles",
    },
    {
      "<leader>sg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "[S]earch by [G]rep",
    },
    {
      "<leader>sh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "[S]earch [H]elp",
    },
    {
      "<leader>gw",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "[G]rep current [W]ord",
    },
    {
      "<leader>sr",
      function()
        require("fzf-lua").resume()
      end,
      desc = "[S]earch [R]esume",
    },
    {
      "<leader>sk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "[S]earch [K]eymaps",
    },
    {
      "<leader>sb",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "[S]earch [B]uiltin FzfLua commands",
    },
    {
      "<leader>st",
      function()
        require("fzf-lua").colorschemes()
      end,
      desc = "[S]earch [T]hemes/Colorscheme",
    },
    {
      "<leader>sc",
      function()
        require("fzf-lua").commands()
      end,
      desc = "[S]earch [C]ommands",
    },
    {
      "<leader>sd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "[S]earch [D]iagnostics",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>sn",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      silent = true,
      desc = "[S]earch [N]vim config",
    },
    {
      "<leader>s.",
      function()
        require("fzf-lua").files({ cwd = "$HOME/dotfiles" })
      end,
      desc = "[S]earch [N]vim config",
    },
    {
      "<leader>s/",
      function()
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
      end,
      desc = "[S]earch [/] in current buffer",
    },
    {
      "<leader>lr",
      function()
        require("fzf-lua").fzf_exec(require("config.utils").pluginNames(), {
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
      end,
      desc = "[L]azy [R]eload plugin of choice",
    },
  },
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
  end,
}
