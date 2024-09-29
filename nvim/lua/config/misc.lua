local autocmd = vim.api.nvim_create_autocmd
-- Open help window in a vertical split to the right.
autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd([[
        wincmd L
        vertical resize 90
      ]])
    end
  end,
})
autocmd({ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" }, {
  desc = "Autosave",
  pattern = "*",
  command = "silent! update",
})

autocmd("FileType", {
  pattern = {
    "checkhealth",
    "fugitive*",
    "git",
    "help",
    "man",
    "lspinfo",
    "netrw",
    "notify",
    "noice",
    "qf",
    "query",
    "Trouble",
    "trouble",
  },
  callback = function()
    vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close the current buffer", buffer = true })
  end,
})

autocmd("FileType", {
  group = vim.api.nvim_create_augroup("disable_mini_indentline", {}),
  pattern = {
    "help",
    "alpha",
    "nofile",
    "",
    "dashboard",
    "neo-tree",
    "Trouble",
    "trouble",
    "lazy",
    "lspinfo",
    "netrw",
    "oil",
    "oil_preview",
    "mason",
    "fzf",
    "notify",
    "nocie",
    "toggleterm",
    "lazyterm",
  },
  desc = "Disable Mini Indentline for some filetype, similar to IndentBlankLine",
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

autocmd("CursorMoved", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("ResizeBuffer", {}),
  desc = "Resize buffer on entry, Alternative to focus.nvim",
  callback = function()
    local excluded_filetypes = {
      "alpha",
      "",
      "nofile",
      "dashboard",
      "neo-tree",
      "Trouble",
      "trouble",
      "netrw",
      "oil",
      "oil_preview",
      "fzf",
      "lazy",
      "lspinfo",
      "mason",
      "notify",
      "noice",
      "toggleterm",
      "lazyterm",
    }
    if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
      vim.cmd("vertical resize " .. math.floor(vim.o.columns / 1.618))
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Replace the default qf window with trouble.nvim
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- vim.cmd([[Trouble qflist open]])
    if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
      vim.defer_fn(function()
        vim.cmd.lclose()
        require("trouble").open("loclist")
      end, 0)
    else
      vim.defer_fn(function()
        vim.cmd.cclose()
        require("trouble").open("quickfix")
      end, 0)
    end
  end,
})

-- Autocmd to track macro recording, And redraw statusline, which trigger
-- macro function of mini.statusline
autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
    vim.g.macro_recording = "Recording @" .. vim.fn.reg_recording()
    vim.cmd("redrawstatus")
  end,
})

-- Autocmd to track the end of macro recording
autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    vim.g.macro_recording = ""
    vim.cmd("redrawstatus")
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

autocmd("VimEnter", {
  desc = "clear the last used search pattern",
  pattern = "*",
  callback = function()
    vim.fn.setreg("/", "") -- Clears the search register
    vim.cmd('let @/ = ""') -- Clear the search register using Vim command
  end,
})

-- vim.api.nvim_create_user_command("Redir", function(ctx)
--   local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
--   vim.cmd("new")
--   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
--   vim.opt_local.modified = false
-- end, { nargs = "+", complete = "command" })
