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

function M.lazyPluginNames()
  local keys = {}
  for _, plugin in ipairs(require("lazy").plugins()) do
    table.insert(keys, plugin.name)
  end

  return keys
end

function M.fixCmpHighlight()
  local function get_hl_color(kind)
    local _, hl, _ = require("mini.icons").get("lsp", kind)
    local seen = {}
    while hl and not seen[hl] do
      seen[hl] = true
      local def = vim.api.nvim_get_hl(0, { name = hl, link = false })
      if def and def.fg then
        return string.format("#%06x", def.fg)
      end
      hl = vim.api.nvim_get_hl(0, { name = hl, link = true }).link
    end
  end

  local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
  end

  local function rgb_to_hex(r, g, b)
    local clamp = function(x)
      return math.max(0, math.min(255, math.floor(x + 0.5)))
    end
    return string.format("#%02x%02x%02x", clamp(r), clamp(g), clamp(b))
  end

  -- Lighten: moves each channel toward 255 by `amount` (0.0–1.0)
  local function lighten(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    return rgb_to_hex(r + (255 - r) * amount, g + (255 - g) * amount, b + (255 - b) * amount)
  end

  -- Darken: scales each channel down by (1 - amount)
  local function darken(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    return rgb_to_hex(r * (1 - amount), g * (1 - amount), b * (1 - amount))
  end

  local kinds = {
    "Enum",
    "File",
    "Text",
    "Unit",
    "Class",
    "Color",
    "Event",
    "Field",
    "Value",
    "Folder",
    "Method",
    "Module",
    "Struct",
    "Keyword",
    "Snippet",
    "Constant",
    "Function",
    "Operator",
    "Property",
    "Variable",
    "Interface",
    "Reference",
    "Number",
    "Constructor",
    "TypeParameter",
    "EnumMember",
  }

  local colors = {}

  for _, kind in ipairs(kinds) do
    colors[kind] = get_hl_color(kind)
  end

  for kind, color in pairs(colors) do
    vim.api.nvim_set_hl(0, "BlinkCmpKind" .. tostring(kind), { bg = lighten(color, 0.3), fg = darken(color, 0.5) })
  end
  -- vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "BlinkCmpDocCursorLine" })
end

return M
