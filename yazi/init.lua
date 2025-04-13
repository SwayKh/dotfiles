require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("personal"):setup()
-- To Implement from lf
-- [Done] Pick Random function
-- [Done] Move to new directory
-- [Done] Drag n Drop function
-- [Done] Mappings
-- [Done] Settings
-- [Done] folder rules
-- [Done] Fix the statusline colors
-- [Done] Make all changed keymaps into prepend_keymap, keep the default config as is,  Easier to share
-- [Done] Fix the hovered file issue
-- [Done] Make the share command work with 0x0.st
-- [Done] Fix the Tabs no folder rules issue
-- Archive functionality

require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" }, --

	permissions_t_fg = "#a6da95",
	permissions_r_fg = "#eed49f",
	permissions_w_fg = "#ed8796",
	permissions_x_fg = "#91d7e3",
	permissions_s_fg = "#b7bdf8",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "#eed49f" },
	copied = { icon = "", fg = "#a6da95" },
	cut = { icon = "", fg = "#ed8796" },

	total = { icon = "", fg = "#eed49f" },
	succ = { icon = "", fg = "#a6da95" },
	fail = { icon = "", fg = "#ed8796" },
	found = { icon = "", fg = "#8aadf4" },
	processed = { icon = "", fg = "#a6da95" },

	show_background = false,

	display_header_line = true,
	display_status_line = true,

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
			},
			section_b = {
				{ type = "string", custom = false, name = "date", params = { "%X" } },
			},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "tab_path" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})
