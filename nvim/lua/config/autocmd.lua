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

autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.opt.background = "dark"
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineSign", { bg = "none" })
  end,
})

-- create directories when needed, when saving a file
autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

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

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
