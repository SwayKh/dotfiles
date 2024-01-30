return {
  "CRAG666/code_runner.nvim",
  lazy = true,
  -- event = "VeryLazy",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },

  config = function()
    require("code_runner").setup({
      filetype = {
        c = {
          "gcc $fullFilePath -o $dir/out",
          "$dir/./out",
        },
        cpp = {
          "g++ $fullFilePath -o $dir/out",
          "$dir/./out",
        },
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        javascript = "node $fullFilePath",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        go = {
          "go run",
        },
      },
      mode = "term", -- Setting this to toggleterm remove the key bind effects
      focus = true,
      startinsert = true, -- Sets the term to insert mode, which exists by default on any keypress
      before_run_filetype = function()
        vim.cmd(":w")
      end,
      term = {
        position = "bot",
        size = 13,
      },
      float = {
        close_key = "<ESC>",
        border = "none",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
      },
    })
    vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rq", ":RunClose<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
  end,
}
