return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- local actions = require("fzf-lua.actions")
    local fzf = require("fzf-lua")
    fzf.setup({
      "fzf-native", -- profiles, options {"default", "telescope", "fzf-native", "fzf-tmux", "fzf-vim"} + :fzflua profiles
      preview = { layout = "horizontal" },
      winopts = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- On by default
        title = "Fzf",
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

      args = { prompt = " ❯ " },
      oldfiles = { prompt = " Recents ❯ " },
      buffers = { prompt = " Buffers ❯ " },
      colorschemes = { prompt = " Themes ❯ " },
      keymaps = { prompt = " Keymaps ❯ " },
      grep = { prompt = " Find ❯ ", no_header_i = true },
      files = { prompt = " Files ❯ ", no_header_i = true, cwd_prompt = false },
      git = {
        files = { prompt = " Git Files ❯ " },
        status = { prompt = " ❯ " },
        commits = { prompt = " ❯ " },
      },

      fzf_opts = {
        ["--info"] = "inline",
        ["--layout"] = "reverse",
        -- ["--header"] = "",
      },
    })

    vim.keymap.set("n", "<leader>/", function()
      require("fzf-lua").grep_curbuf({
        winopts = {
          preview = { hidden = "hidden" },
          height = 0.45, -- window height
          width = 0.60, -- window width
          row = 0.50, -- window row position (0=top, 1=bottom)
          col = 0.50, -- window col position (0=left, 1=right)
        },
      })
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>?", ":FzfLua oldfiles<CR>", { silent = true, desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", ":FzfLua buffers<CR>", { silent = true, desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>gf", ":FzfLua git_files<CR>", { silent = true, desc = "Search [G]it [F]iles" }) --git_files
    vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>", { silent = true, desc = "[S]earch [F]iles" }) --find_files
    vim.keymap.set("n", "<leader>sh", ":FzfLua help_tags<CR>", { silent = true, desc = "[S]earch [H]elp" }) --help_tags
    vim.keymap.set("n", "<leader>sw", ":FzfLua grep_cword<CR>", { silent = true, desc = "[S]earch current [W]ord" }) --grep_string
    vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>", { silent = true, desc = "[S]earch by [G]rep" }) --live_grep
    vim.keymap.set(
      "n",
      "<leader>sd",
      ":FzfLua diagnostics_document<CR>",
      { silent = true, desc = "[S]earch [D]iagnostics" }
    ) --diagnostics
    vim.keymap.set("n", "<leader>sr", ":FzfLua resume<CR>", { silent = true, desc = "[S]earch [R]esume" }) --resume
    vim.keymap.set(
      "n",
      "<leader>sb",
      ":FzfLua builtin<CR>",
      { silent = true, desc = "[S]earch [B]uiltin FzfLua commands" }
    ) --resume

    vim.keymap.set(
      "n",
      "<leader>st",
      ":FzfLua colorschemes<CR>",
      { silent = true, desc = "Fzf [S]earch [T]hemes/Colorscheme" }
    )
    vim.keymap.set("n", "<leader>sk", ":FzfLua keymaps<CR>", { silent = true, desc = "Fzf [S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sc", ":FzfLua commands<CR>", { silent = true, desc = "Fzf [S]earch [C]ommands" })
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