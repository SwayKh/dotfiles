local get_selected = ya.sync(function()
	local paths = {}
	local selected = cx.active.selected
	for _, v in pairs(selected) do
		paths[#paths + 1] = tostring(v)
	end
	if #paths == 0 and cx.active.current.hovered then
		paths[1] = tostring(cx.active.current.hovered.url)
	end
	return paths
end)

--==========================--
--      Setup Functions      --
--==========================--

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

local function folder_rules()
	ps.sub("cd", function()
		local cwd = cx.active.current.cwd
		if cwd:ends_with("Downloads") then
			ya.manager_emit("sort", { "modified", reverse = true, dir_first = true })
		elseif cwd:ends_with("Screenshots") then
			ya.manager_emit("sort", { "created", reverse = true })
		else
			ya.manager_emit("sort", { "natural", reverse = false, dir_first = true })
		end
	end)
end

--==========================--
--  Keymap/Plugin Functions  --
--==========================--

local st = {}
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

	if st.old then
		Tab.layout, st.old = st.old, nil
	else
		st.old = Tab.layout
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
	end
	ya.app_emit("resize", {})
end

local function pick_random()
	local files = cx.active.current.files
	ya.manager_emit("reveal", { files[math.random(1, #files)].name })
end

local function smart_enter()
	local h = cx.active.current.hovered
	ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
end

local function move_parent(args)
	local parent = cx.active.parent
	if not parent then
		return
	end

	local target = parent.files[parent.cursor + 1 + args[2]]
	if target and target.cha.is_dir then
		ya.manager_emit("cd", { target.url })
	end
end

local function move_to_new_dir()
	local paths = get_selected()
	if #paths == 0 then
		return ya.notify({ title = "Chmod", content = "No file selected", level = "warn", timeout = 5 })
	end

	local value, _ = ya.input({
		title = "Directory name:",
		position = { "top-center", y = 3, w = 40 },
	})
	local status, err = Command("mkdir"):args({ "-p", value }):status()
	if not status or not status.success then
		ya.notify({
			title = "Mkdir",
			content = string.format("Mkdir command failed, exit code %s", status and status.code or err),
			level = "error",
			timeout = 5,
		})
	end

	for i = 1, #paths do
		local stat, error = Command("mv"):args({ paths[i], value }):status()
		if not stat or not stat.success then
			ya.notify({
				title = "Mkdir",
				content = string.format("Mkdir command failed, exit code %s", status and status.code or error),
				level = "error",
				timeout = 5,
			})
		end
	end
end

local function share()
	local paths = get_selected()
	if #paths == 0 then
		return ya.notify({ title = "Chmod", content = "No file selected", level = "warn", timeout = 5 })
	end

	local curl, err =
		Command("curl"):args({ "-F", "file=@" .. paths[1], "https://0x0.st" }):stdout(Command.PIPED):output()

	if not curl then
		ya.notify({
			title = "Share",
			content = "Cannot spawn git command, error code " .. tostring(err),
			level = "error",
			timeout = 5,
		})
	end

	local copy, error = Command("wl-copy"):arg(curl.stdout):status()

	if copy or copy.success then
		ya.notify({
			title = "Share",
			content = "File shared, and link copied to clipboard",
			level = "info",
			timeout = 5,
		})
	end

	if not copy then
		ya.notify({
			title = "Share",
			content = "Cannot spawn wl-copy, error " .. tostring(error),
			level = "warn",
			timeout = 5,
		})
	end
end

local function chmodx()
	ya.manager_emit("escape", { visual = true })

	local urls = get_selected()
	if #urls == 0 then
		return ya.notify({ title = "Chmod", content = "No file selected", level = "warn", timeout = 5 })
	end

	local status, err = Command("chmod"):arg("+x"):args(urls):spawn():wait()
	if not status or not status.success then
		ya.notify({
			title = "Chmod",
			content = string.format("Chmod with selected files failed, exit code %s", status and status.code or err),
			level = "error",
			timeout = 5,
		})
	end
end

local function chmod()
	ya.manager_emit("escape", { visual = true })

	local urls = get_selected()
	if #urls == 0 then
		return ya.notify({ title = "Chmod", content = "No file selected", level = "warn", timeout = 5 })
	end

	local value, event = ya.input({
		title = "Chmod:",
		position = { "top-center", y = 3, w = 40 },
	})
	if event ~= 1 then
		return
	end

	local status, err = Command("chmod"):arg(value):args(urls):spawn():wait()
	if not status or not status.success then
		ya.notify({
			title = "Chmod",
			content = string.format("Chmod with selected files failed, exit code %s", status and status.code or err),
			level = "error",
			timeout = 5,
		})
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
	elseif args[1] == "smart_enter" then
		smart_enter()
	elseif args[1] == "move_parent" then
		move_parent(args)
	elseif args[1] == "chmod" then
		chmod()
	elseif args[1] == "chmodx" then
		chmodx()
	elseif args[1] == "share" then
		share()
	end
end

-- Setup function to call all UI Change functions
local function setup(_, opts)
	show_link()
	show_user()
	folder_rules()

	-- Create 2 tabs on startup and switch to first one
	ya.manager_emit("tab_create", { os.getenv("HOME") })
	ya.manager_emit("tab_switch", { 0 })
end

return { entry = entry, setup = setup }
