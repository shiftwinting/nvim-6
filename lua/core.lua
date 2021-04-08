local global = require("global")
local vim = vim
local g = vim.g

-- Create cache dir and subs dir
local data_dir = {
	global.cache_dir .. "backup",
	global.cache_dir .. "session",
	global.cache_dir .. "swap",
	global.cache_dir .. "tags",
	global.cache_dir .. "undo",
}
if vim.fn.isdirectory(global.cache_dir) == 0 then
	os.execute("mkdir -p " .. global.cache_dir)
	for _, v in pairs(data_dir) do
		if vim.fn.isdirectory(v) == 0 then
			os.execute("mkdir -p " .. v)
		end
	end
end

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
require("mapping")
require("autocmd")
require("colorscheme").init()

-- load profile.vim if existed
local profile = global.vim_path .. "profile.vim"
if vim.fn.filereadable(profile) > 0 then
	vim.cmd("source " .. profile)
end
