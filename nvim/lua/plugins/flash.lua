return {
  "folke/flash.nvim",
  event = { "BufReadPost", "BufNewFile" },
  -- stylua: ignore
  keys = {
    -- Switch s mapping for m (taken from leap), s is being used by mini.surround
    { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
