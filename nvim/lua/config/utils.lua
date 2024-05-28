local M = {}

function M.pluginNames()
  local function readFile(filepath)
    local file = io.open(filepath, "r")
    if not file then
      print("Failed to open file:", filepath)
      return nil
    end
    local content = file:read("*a") -- Read the entire file content
    file:close()
    return content
  end

  local lazyLock = "~/.config/nvim/lazy-lock.json"
  local content = readFile(vim.fn.expand(lazyLock)) -- Expand the '~'
  if not content then
    print("Failed to read file.")
    return
  end

  -- Lua json decoder needs some package from luarocks
  -- Decode JSON content to a Lua table using Neovim's json_decode
  local data = vim.fn.json_decode(content)
  if not data then
    print("Failed to decode JSON.")
    return
  end

  local keys = {}
  for key, _ in pairs(data) do
    table.insert(keys, key)
  end

  return keys
end

return M
