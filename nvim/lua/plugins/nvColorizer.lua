return {
  "NvChad/nvim-colorizer.lua",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      filetype = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        -- names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        -- mode = "background", -- Set the display mode.
        mode = "virtualtext", -- Set the display mode.
        virtualtext = "",
      },
      buftypes = {},
    })
  end,
}
