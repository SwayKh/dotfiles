local autocmd = vim.api.nvim_create_autocmd
-- Open help|man window in a vertical split to the right.
autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
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

-- Clear cmdline messages after 1 sec
-- autocmd("CmdlineLeave", {
--   group = vim.api.nvim_create_augroup("clearcmdline", { clear = true }),
--   callback = function()
--     vim.defer_fn(function()
--       vim.cmd('echo ""')
--     end, 1000) -- 1000ms delay
--   end,
-- })

-- create directories when needed, when saving a file
autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- autocmd({ "CursorMoved", "BufEnter" }, {
--   pattern = "*",
--   desc = "Center cursor on CursorMoved event",
--   callback = function()
--     -- vim.api.nvim_feedkeys("zz", "n", false)
--     vim.cmd("norm! zz")
--   end,
-- })

autocmd("CursorMoved", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("ResizeBuffer", {}),
  desc = "Resize buffer on entry, Alternative to focus.nvim",
  callback = function()
    local excluded_filetypes = {
      "neo-tree",
      "Trouble",
      "trouble",
      "netrw",
    }
    -- This handles all floating windows
    local win = vim.api.nvim_win_get_config(0)
    if win.relative ~= "" then
      return
    end
    if not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) then
      vim.cmd("vertical resize " .. math.floor(vim.o.columns / 1.618))
    end
  end,
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble qflist open]])
      end)
    end
  end,
})

autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
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

autocmd("BufReadPre", {
  desc = "clear the last used search pattern",
  pattern = "*",
  callback = function()
    vim.fn.setreg("/", "") -- Clears the search register
    vim.cmd('let @/ = ""') -- Clear the search register using Vim command
  end,
})

-- autocmd("Redir", function(ctx)
--   local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
--   vim.cmd("new")
--   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
--   vim.opt_local.modified = false
-- end, { nargs = "+", complete = "command" })
