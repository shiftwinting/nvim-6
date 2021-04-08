local fn, cmd = vim.fn, vim.cmd

local cache_theme_path = require("global").cache_dir .. "theme"
local default_theme = "one"

-- Must be set before loading the theme, otherwise, it won't have any effect.
local theme_configs = {
	sonokai = function()
		vim.g.sonokai_better_performance = 1
		vim.g.sonokai_style = "atlantis"
	end,
	edge = function()
		vim.g.edge_better_performance = 1
		vim.g.edge_style = "aura"
	end,
}

local function init()
	if not vim.g.colors_name then
		if fn.empty(fn.glob(cache_theme_path)) > 0 then
			theme = default_theme
		else
			file = io.open(cache_theme_path, "r")
			theme = file:read()
			file:close()
		end
		if theme_configs[theme] then
			theme_configs[theme]()
		end
		cmd("colorscheme " .. theme)
	end
end

local function cache_theme()
	if vim.g.colors_name then
		fn.writefile({ vim.g.colors_name }, cache_theme_path)
	end
end

local function clean()
	if vim.g.colors_name then
		cmd([[highlight clear]])
	end
end

return { init = init, cache_theme = cache_theme, clean = clean }