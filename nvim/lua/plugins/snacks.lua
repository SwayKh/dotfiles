require("snacks").setup({
  bigfile = { enabled = false },
  explorer = { enabled = false },
  image = { enabled = false },
  picker = { enabled = false },
  profiler = { enabled = false },
  quickfile = { enabled = false },
  scope = { enabled = false },
  statuscolumn = { enabled = false },
  words = { enabled = false },

  animate = {
    enabled = true,
    duration = 20, -- ms per step
    easing = "linear",
    fps = 60, -- frames per second. Global setting for all animations
  },

  dashboard = {
    enabled = true,
    preset = {
      pick = "mini.pick",
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = "<leader>fg" },
        { icon = " ", key = "r", desc = "Recent Files", action = "<leader>f?" },
        { icon = " ", key = "c", desc = "Config", action = "<leader>fn" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", padding = 1 },
      { icon = " ", title = "Projects", section = "projects", padding = 1 },
    },
  },

  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
    indent = {
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
        "SnacksIndent5",
        "SnacksIndent6",
        "SnacksIndent7",
        "SnacksIndent8",
      },
    },
    scope = {
      enabled = false,
      underline = true,
    },
  },

  input = { enabled = true },

  notifier = {
    enabled = true,
    timeout = 3000,
    style = "fancy",
  },

  scroll = {
    enabled = true,
    animate = {
      duration = { step = 10, total = 150 },
      easing = "linear",
    },
    spamming = 10, -- threshold for spamming detection
  },

  terminal = {
    enabled = true,
    win = {
      style = "terminal",
      border = vim.g.border_style,
      position = "float",
      height = 0.9,
      width = 0.9,
    },
  },

  styles = {
    notification = {
      border = vim.g.border_style,
      wo = { wrap = true }, -- Wrap notifications
      history = {
        border = vim.g.border_style,
      },
    },
    scratch = {
      border = vim.g.border_style,
    },
  },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>z",    function() Snacks.zen() end,                     { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z",    function() Snacks.zen.zoom() end,                { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>.",    function() Snacks.scratch() end,                 { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S",    function() Snacks.scratch.select() end,          { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>n",    function() Snacks.notifier.show_history() end,   { desc = "Notification History" })
vim.keymap.set("n", "<leader>un",   function() Snacks.notifier.hide() end,           { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<leader>bd",   function() Snacks.bufdelete() end,               { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>lg",   function() Snacks.lazygit() end,                 { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gb",   function() Snacks.git.blame_line() end,          { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gB",   function() Snacks.gitbrowse() end,               { desc = "Git Browse" })
vim.keymap.set("n", "<leader>lf",   function() Snacks.lazygit.log_file() end,        { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gl",   function() Snacks.lazygit.log() end,             { desc = "Lazygit Log (cwd)" })
vim.keymap.set("n", "<leader>cr",   function() Snacks.rename() end,                  { desc = "Rename File" })
vim.keymap.set("n", "<leader>ss",   function() Snacks.picker() end,                  { desc = "Open Snacks Picker picker" })
vim.keymap.set("n", "<leader>ps",   function() Snacks.profiler.scratch() end,        { desc = "Profiler Scratch Buffer" })
vim.keymap.set({"n", "t"}, "<c-,>", function() Snacks.terminal.toggle() end,         { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "]]",  function() Snacks.words.jump(vim.v.count1) end,  { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[",  function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
-- stylua: ignore end

vim.keymap.set("n", "<leader>N", function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd -- Override print to use snacks for `:=` command

-- Create some toggle mappings
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>uS")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.profiler():map("<leader>pp")
Snacks.toggle.profiler_highlights():map("<leader>ph")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.scroll():map("<leader>us")

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

local progress = vim.defaulttable()

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {}
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
