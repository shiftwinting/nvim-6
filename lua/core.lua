require("globals")
require("options")
require("plugins")
require("mappings")
require("autocmd")
require("whitespace")
require("colorscheme").init()

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

-- load profile.vim if existed
local profile = CONFIG_PATH .. "/profile.vim"
if vim.fn.filereadable(profile) > 0 then
  vim.cmd("source " .. profile)
end
