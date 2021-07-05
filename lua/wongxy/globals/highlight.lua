wxy.highlight = function(name, opts, clear)
  clear = clear or false
  local cmd = {}
  if type(opts) == "string" then
    cmd = { "highlight" .. (clear and "!" or ""), "link", name, opts }
  else
    cmd = { "highlight" .. (clear and "!" or ""), name }
    for k, v in pairs(opts) do
      table.insert(cmd, k .. "=" .. v)
    end
  end

  local ok, msg = pcall(vim.cmd, table.concat(cmd, " "))
  if not ok then
    vim.notify(string.format("Failed to set %s because: %s", name, msg))
  end
end

wxy.highlight_all = function(hls)
  for _, hl in ipairs(hls) do
    wxy.highlight(unpack(hl))
  end
end

wxy.hi_value = (function()
  local gui_attr = { "underline", "bold", "undercurl", "italic" }
  local attrs = { fg = "foreground", bg = "background" }
  ---get the color value of part of a highlight group
  ---@param grp string
  ---@param attr string
  ---@param fallback string
  ---@return string
  return function(grp, attr, fallback)
    if not grp then
      return vim.notify("Cannot get a highlight without specifying a group")
    end
    attr = attrs[attr] or attr
    local hl = vim.api.nvim_get_hl_by_name(grp, true)
    if attr == "gui" then
      local gui = {}
      for name, value in pairs(hl) do
        if value and vim.tbl_contains(gui_attr, name) then
          table.insert(gui, name)
        end
      end
      return table.concat(gui, ",")
    end
    local color = hl[attr] or fallback
    -- convert the decimal rgba value from the hl by name to a 6 character hex + padding if needed
    if not color then
      -- vim.notify(string.format("%s %s does not exist", grp, attr))
      return "NONE"
    end
    return "#" .. bit.tohex(color, 6)
  end
end)()

---Convert a hex color to rgb
---@param color string
---@return number
---@return number
---@return number
local function hex_to_rgb(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

---@source https://stackoverflow.com/q/5560248
---@see: https://stackoverflow.com/a/37797380
---Darken a specified hex color
---@param color string
---@param percent number
---@return string
function wxy.darken_color(color, percent)
  local r, g, b = hex_to_rgb(color)
  if not r or not g or not b then
    return "NONE"
  end
  r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
  r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
  return string.format("#%02x%02x%02x", r, g, b)
end
