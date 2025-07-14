vim.o.cmdheight = 0
vim.o.laststatus = 0
vim.o.shadafile = "NONE"
vim.o.termguicolors = true

vim.api.nvim_set_hl(0, "Normal", { fg = "#999999", bg = "NONE", ctermbg = "NONE" })

vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  pattern = "*",
  callback = function()
    local path = vim.fn.argv()[1]
    path = (path and path ~= "") and path or vim.fn.getcwd()
    vim.cmd("startinsert")
    vim.fn.termopen({ "yazi", path }, {
      on_exit = function()
        vim.cmd("q")
      end,
    })
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   once = true,
--   pattern = "*",
--   callback = function()
--     local path = vim.fn.argv(0)
--     path = (#path > 0) and path or vim.fn.getcwd()
--
--     -- Open an empty terminal buffer
--     local buf = vim.api.nvim_create_buf(false, true)
--     local win = vim.api.nvim_get_current_win()
--     vim.api.nvim_win_set_buf(win, buf)
--
--     vim.cmd("startinsert")
--
--     -- Start the yazi job and connect it to the terminal buffer
--     local job_id = vim.fn.jobstart({ "yazi", path }, {
--       stdout_buffered = false,
--       stderr_buffered = false,
--       pty = true,
--       on_exit = function()
--         vim.schedule(function()
--           vim.cmd("qa!")
--         end)
--       end,
--     })
--
--     -- Attach terminal UI to the job
--     vim.fn.termopen("cat", { pty = true }) -- dummy to mark terminal mode
--     vim.b.terminal_job_id = job_id
--   end,
-- })
