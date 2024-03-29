-- Put this in for working with TMUX, Don't know if I'll need it
-- vim.cmd([[
-- if &term =~ '^screen'
-- " tmux will send xterm-style keys when its xterm-keys option is on
-- execute "set <xUp>=\e[1;*A"
-- execute "set <xDown>=\e[1;*B"
-- execute "set <xRight>=\e[1;*C"
-- execute "set <xLeft>=\e[1;*D"
-- endif
-- ]])

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
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

-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("conf_filetype", {}),
--   pattern = { "*.conf", "*.ini", "*.rasi", "*.cfg" },
--   callback = function()
--     vim.cmd("set filetype=conf")
--   end,
-- })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- vim.api.nvim_create_autocmd("RecordingEnter", {
--   callback = function()
--     require("lualine").refresh({
--       place = { "statusline" },
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd("RecordingLeave", {
--   callback = function()
--     -- This is going to seem really weird!
--     -- Instead of just calling refresh we need to wait a moment because of the nature of
--     -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
--     -- still show a recording occurring because `vim.fn.reg_recording` hasn't emptied yet.
--     -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
--     -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
--     local timer = vim.loop.new_timer()
--     timer:start(
--       50,
--       0,
--       vim.schedule_wrap(function()
--         require("lualine").refresh({
--           place = { "statusline" },
--         })
--       end)
--     )
--   end,
-- })
vim.api.nvim_create_user_command("Redir", function(ctx)
  local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
  vim.cmd("new")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = "+", complete = "command" })

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = vim.schedule_wrap(function()
--     if vim.fn.argv(0) == "" then
--       require("oil").open()
--     end
--   end),
-- })
