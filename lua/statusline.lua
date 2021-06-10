local lualine = require("lualine")

local colors = {
	bg = "NONE", --"#202328",
	fg = "#f1f2f6",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}
local mode_color = {
	n = colors.red,
	i = colors.green,
	v = colors.blue,
	[""] = colors.blue,
	V = colors.blue,
	c = colors.magenta,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}
local mode_symbol = {
	n = " ",
	i = " ",
	v = " ",
	[""] = " ",
	V = " ",
	c = "↪ ",
	no = " ",
	s = " ",
	S = " ",
	[""] = " ",
	ic = " ",
	R = " ",
	Rv = " ",
	cv = "↪ ",
	ce = "↪ ",
	r = " ",
	rm = " ",
	["r?"] = " ",
	["!"] = "SE",
	t = "ﭨ ",
}

-- Config
local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	extensions = { "nvim-tree", "quickfix" },
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▌"
	end,
	color = { fg = colors.blue }, -- Sets highlighting of component
	left_padding = 0, -- We don't need space before this
})

ins_left({
	-- Vim Mode
	function()
		local mode = vim.fn.mode()
		vim.cmd("hi! LualineMode guifg=" .. mode_color[mode] .. " guibg=" .. colors.bg)
		return mode_symbol[mode]
	end,
	color = "LualineMode",
})

ins_left({ "mode", left_padding = 0 })

ins_left({
	function()
		if #vim.bo.filetype > 0 then
			local ok, devicons = pcall(require, "nvim-web-devicons")
			if ok then
				local icon, icon_hi =
					devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
				vim.cmd("hi! link LualineFileIcon " .. icon_hi)
				return icon
			end
		end
		vim.cmd("hi! LualineFileIcon guifg=#c2ccd0")
		return ""
	end,
	color = "LualineFileIcon",
})

ins_left({
	function()
		local icon = ""
		if vim.bo.readonly then
			icon = ""
		else
			if vim.bo.modifiable then
				if vim.bo.modified then
					icon = ""
				else
					icon = ""
				end
			end
		end
		return vim.fn.expand("%:~:.") .. " " .. icon
	end,
	condition = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
	left_padding = 0,
})

ins_left({ "location" })

ins_left({
	"diagnostics",
	sources = { "coc" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	color_error = colors.red,
	color_warn = colors.yellow,
	color_info = colors.cyan,
	color_info = colors.blue,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left({ function()
--   return "%="
-- end })

ins_left({ "g:coc_status", icon = "", color = { fg = colors.green, gui = "bold" } })

ins_right({ "b:coc_current_function", color = { fg = colors.yellow, gui = "bold" } })

ins_right({
	"branch",
	icon = "",
	condition = conditions.check_git_workspace,
	color = { fg = colors.violet, gui = "bold" },
})

ins_right({
	"diff",
	symbols = { added = " ", modified = " ", removed = " " },
	color_added = colors.green,
	color_modified = colors.orange,
	color_removed = colors.red,
	condition = conditions.hide_in_width,
})

ins_right({
	function()
		return os.date("%H:%M")
	end,
	icon = "",
})

ins_right({
	function()
		return "▌"
	end,
	color = { fg = colors.blue },
	right_padding = 0,
})

lualine.setup(config)
