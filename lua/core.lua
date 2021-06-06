-- Initialize global variables
require("global")

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

local g = vim.g

-- Disable vim distribution plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

-- leader map
g.mapleader = ","

require("plugins")
require("options")
require("keymap")
require("autocmd")
require("colorscheme").init()

-- load profile.vim if existed
local profile = VIM_PATH .. "/profile.vim"
if vim.fn.filereadable(profile) > 0 then
  vim.cmd("source " .. profile)
end
