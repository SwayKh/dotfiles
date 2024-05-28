-- Function to read the entire content of a file
local function readFile(filename)
  local file = io.open(filename, "r") -- Open the file in read mode
  if not file then
    print("Failed to open file:", filename)
    return nil
  end
  local content = file:read("*a") -- Read the entire file content
  file:close() -- Close the file
  return content
end

-- Function to decode JSON and extract keys
local function extractKeysFromJson(filename)
  local content = readFile(filename) -- Read file content
  if not content then
    print("Failed to read file.")
    return
  end

  -- Decode JSON content to a Lua table using Neovim's json_decode
  local data = vim.fn.json_decode(content)
  if not data then
    print("Failed to decode JSON.")
    return
  end

  -- Iterate over the keys and print them
  local keys = {}
  for key, _ in pairs(data) do
    table.insert(keys, key)
  end

  return keys
end

-- Specify the path to your JSON file
local jsonFilePath = "~/.config/nvim/lazy-lock.json" -- Replace with the actual path

-- Function to launch fzf-lua with the extracted keys
local function fzfPluginPicker()
  local plugins = extractKeysFromJson(vim.fn.expand(jsonFilePath))
  require("fzf-lua").fzf_exec(plugins, {
    prompt = "Select a plugin > ",
    actions = {
      ["default"] = function(selected)
        vim.cmd("Lazy reload " .. selected[1])
      end,
    },
    winopts = {
      title = " Reload Plugins ",
      title_pos = "center",
      preview = { hidden = "hidden" },
      height = 0.40, -- window height
      width = 0.40, -- window width
      row = 0.50, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
    },
  })
end

return {
  fzfPluginPicker = fzfPluginPicker,
}
