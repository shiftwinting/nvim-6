require("wongxy.globals")
require("wongxy.options")
require("wongxy.plugins")
require("wongxy.colorscheme")
require("wongxy.statusline")

-- Create cache dir and subs dir
local data_dir = {
  CACHE_PATH .. "backup",
  CACHE_PATH .. "session",
  CACHE_PATH .. "swap",
  CACHE_PATH .. "tags",
  CACHE_PATH .. "undo",
}

if vim.fn.isdirectory(CACHE_PATH) == 0 then
  os.execute("mkdir -p " .. CACHE_PATH)
  for _, v in pairs(data_dir) do
    if vim.fn.isdirectory(v) == 0 then
      os.execute("mkdir -p " .. v)
    end
  end
end

-- load local profile
pcall(vim.cmd, "source " .. CONFIG_PATH .. "/profile.vim")
pcall(vim.cmd, "luafile " .. CONFIG_PATH .. "/profile.lua")
