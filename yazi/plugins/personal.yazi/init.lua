local function show_link()
	function Status:name()
		local h = self._tab.current.hovered
		if not h then
			return ui.Line({})
		end

		local linked = ""
		if h.link_to ~= nil then
			linked = " -> " .. tostring(h.link_to)
		end
		return ui.Line(" " .. h.name .. linked)
	end
end

local function show_user()
	Header:children_add(function()
		if ya.target_family() ~= "unix" then
			return ui.Line({})
		end
		return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
	end, 500, Header.LEFT)
end

local function resize_pane(args)
	local a = tonumber(args[2])
	local b = tonumber(args[3])
	local c = tonumber(args[4])

	local total = a + b + c
	if total == 0 then
		return
	end

	local pane_a = math.floor((a / total) * 100 + 0.5)
	local pane_b = math.floor((b / total) * 100 + 0.5)
	local pane_c = math.floor((c / total) * 100 + 0.5)

	Tab.layout = function(self)
		self._chunks = ui.Layout()
			:direction(ui.Layout.HORIZONTAL)
			:constraints({
				ui.Constraint.Percentage(pane_a),
				ui.Constraint.Percentage(pane_b),
				ui.Constraint.Percentage(pane_c),
			})
			:split(self._area)
	end
	ya.app_emit("resize", {})
end

local function pick_random()
	local files = cx.active.current.files
	ya.manager_emit("reveal", { files[math.random(1, #files)].name })
end

local get_selected = ya.sync(function()
	local paths = {}
	local selected = cx.active.selected
	for _, v in pairs(selected) do
		paths[#paths + 1] = tostring(v)
	end
	return paths
end)

local function move_to_new_dir()
	local paths = get_selected()

	local value, _ = ya.input({
		title = "Directory name:",
		position = { "top-center", y = 3, w = 40 },
	})
	local status, err = Command("mkdir"):args({ "-p", value }):status()

	for i = 1, #paths do
		local st, error = Command("mv"):args({ paths[i], value }):status()
	end
end

-- Entry function decides which function to call based on first arg
local function entry(_, args)
	if args[1] == "resize" then
		resize_pane(args)
	elseif args[1] == "random" then
		pick_random()
	elseif args[1] == "new_dir" then
		move_to_new_dir()
	end
end

-- Setup function to call all UI Change functions
local function setup(_, opts)
	show_link()
	show_user()

	-- Create 2 tabs on startup and switch to first one
	ya.manager_emit("tab_create", { current = true })
	ya.manager_emit("tab_switch", { 0 })
end

return { entry = entry, setup = setup }
