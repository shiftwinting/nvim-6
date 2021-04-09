local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista", "dbui" }

local colors = {
	bg = "NONE",
	line_bg = "NONE",
	fg = "#c0c0c0",

	yellow = "#fabd2f",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#afd700",
	orange = "#FF8800",
	purple = "#5d4d7a",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local mode_color = {
	n = colors.magenta,
	i = colors.green,
	v = colors.blue,
	[""] = colors.blue,
	V = colors.blue,
	c = colors.red,
	no = colors.magenta,
	s = colors.orange,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.yellow,
	R = colors.purple,
	Rv = colors.purple,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	["r?"] = colors.cyan,
	["!"] = colors.red,
	t = colors.red,
}

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

-----------------------
-- left
-----------------------
gls.left[1] = {
	FirstElement = {
		provider = function()
			vim.api.nvim_command("hi GalaxyFirstElement guifg=" .. mode_color[vim.fn.mode()])
			return "▊ "
		end,
		highlight = { colors.blue, colors.line_bg },
	},
}
gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
			return "  "
		end,
		highlight = { colors.red, colors.line_bg, "bold" },
	},
}
gls.left[3] = {
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,
		highlight = {
			require("galaxyline.provider_fileinfo").get_file_icon_color,
			colors.line_bg,
		},
	},
}
gls.left[4] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		highlight = { colors.fg, colors.line_bg, "bold" },
	},
}

local function find_git_root()
	local path = vim.fn.expand("%:p:h")
	local get_git_dir = require("galaxyline.provider_vcs").get_git_dir
	return get_git_dir(path)
end

gls.left[5] = {
	GitIcon = {
		provider = function()
			return "   "
		end,
		condition = find_git_root,
		highlight = { colors.orange, colors.line_bg },
	},
}
gls.left[6] = {
	GitBranch = {
		provider = "GitBranch",
		condition = find_git_root,
		highlight = { colors.fg, colors.line_bg, "bold" },
	},
}

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

gls.left[7] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = "   ",
		highlight = { colors.green, colors.line_bg },
	},
}
gls.left[7] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = "   ",
		highlight = { colors.green, colors.line_bg },
	},
}
gls.left[8] = {
	Spacer = {
		provider = function()
			return " "
		end,
		highlight = { colors.orange, colors.line_bg },
	},
}
gls.left[9] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = "   ",
		highlight = { colors.red, colors.line_bg },
	},
}
gls.left[11] = {
	LeftEnd = {
		provider = function()
			return ""
		end,
		separator = "",
		separator_highlight = { colors.bg, colors.line_bg },
		highlight = { colors.line_bg, colors.line_bg },
	},
}
gls.left[12] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "   ",
		highlight = { colors.red, colors.bg },
	},
}
gls.left[13] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "   ",
		highlight = { colors.blue, colors.bg },
	},
}
gls.left[14] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "   ",
		highlight = { colors.blue, colors.bg },
	},
}
gls.left[15] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "   ",
		highlight = { colors.orange, colors.bg },
	},
}
gls.left[16] = {
	CocStatus = {
		provider = function()
			local status = vim.api.nvim_eval("get(g:, 'coc_status', '')")
			return " " .. status
		end,
		highlight = { colors.fg, colors.bg },
	},
}
-----------------------
-- right
-----------------------
gls.right[1] = {
	CocCurrentFunction = {
		provider = function()
			local func = vim.api.nvim_eval("get(b:, 'coc_current_function', '')")
			return func .. "   "
		end,
		highlight = { colors.fg, colors.bg },
	},
}
gls.right[2] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " ",
		separator_highlight = { colors.bg, colors.line_bg },
		highlight = { colors.fg, colors.line_bg },
	},
}
gls.right[3] = {
	FileType = {
		provider = "FileTypeName",
		separator = " | ",
		separator_highlight = { colors.blue, colors.line_bg },
		highlight = { colors.fg, colors.line_bg },
	},
}
gls.right[4] = {
	FileFormat = {
		provider = "FileFormat",
		separator = " | ",
		separator_highlight = { colors.blue, colors.line_bg },
		highlight = { colors.fg, colors.line_bg },
	},
}
gls.right[5] = {
	PerCent = {
		provider = "LinePercent",
		separator = " ",
		separator_highlight = { colors.line_bg, colors.line_bg },
		highlight = { colors.fg, "NONE" },
	},
}

-----------------------
-- short_line_left
-----------------------
gls.short_line_left[1] = {
	BufferType = {
		provider = "FileTypeName",
		separator = " ",
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.fg, "NONE" },
	},
}
-----------------------
-- short_line_right
-----------------------
gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		separator = " ",
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.fg, "NONE" },
	},
}
