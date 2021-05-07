local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local left_list = {}
local right_list = {}
local short_left_list = {}
local short_right_list = {}
function left_list:append(t)
  table.insert(self, t)
end
function right_list:append(t)
  table.insert(self, t)
end
function short_left_list:append(t)
  table.insert(self, t)
end
function short_right_list:append(t)
  table.insert(self, t)
end
-------------------------------------

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

local find_git_root = function()
  local path = vim.fn.expand("%:p:h")
  local get_git_dir = require("galaxyline.provider_vcs").get_git_dir
  return get_git_dir(path)
end

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

left_list:append({
  FirstElement = {
    provider = function()
      vim.api.nvim_command("hi GalaxyFirstElement guifg=" .. mode_color[vim.fn.mode()])
      return "▊ "
    end,
    highlight = { colors.blue, colors.line_bg },
  },
})
left_list:append({
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return "  "
    end,
    highlight = { colors.red, colors.line_bg, "bold" },
  },
})

-- FileSize
left_list:append({
  FileSize = {
    provider = "FileSize",
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.line_bg, "italic" },
  },
})
-- FileIcon
left_list:append({
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = {
      require("galaxyline.provider_fileinfo").get_file_icon_color,
      colors.line_bg,
    },
  },
})
-- FileName
left_list:append({
  FileName = {
    provider = {
      function()
        local file = vim.fn.expand("%:~:.")
        if vim.fn.empty(file) == 1 then
          return ""
        end
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
        return file .. " " .. icon .. " "
      end,
    },
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.line_bg },
  },
})

-- GitBranch
left_list:append({
  GitBranch = {
    provider = "GitBranch",
    icon = "   ",
    condition = find_git_root,
    highlight = { colors.orange, colors.line_bg, "bold" },
  },
})
-- Git diff = add
left_list:append({
  DiffAdd = {
    provider = function()
      local add = vim.api.nvim_eval("get(b:, 'coc_git_status', '')"):match("+(%d+)")
      return add or ""
    end,
    condition = checkwidth,
    icon = "   ",
    highlight = { colors.green, colors.line_bg },
  },
})
-- Git diff = change
left_list:append({
  DiffChange = {
    provider = function()
      local change = vim.api.nvim_eval("get(b:, 'coc_git_status', '')"):match("~(%d+)")
      return change or ""
    end,
    condition = checkwidth,
    icon = "   ",
    highlight = { colors.blue, colors.line_bg },
  },
})
-- Git diff = remove
left_list:append({
  DiffRemove = {
    provider = function()
      local remove = vim.api.nvim_eval("get(b:, 'coc_git_status', '')"):match("-(%d+)")
      return remove or ""
    end,
    condition = checkwidth,
    icon = "   ",
    highlight = { colors.red, colors.line_bg },
  },
})

-- lsp diagnostic = error
left_list:append({
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "   ",
    highlight = { colors.red, colors.bg },
  },
})
-- lsp diagnostic = warn
left_list:append({
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "   ",
    highlight = { colors.blue, colors.bg },
  },
})
-- lsp diagnostic = hint
left_list:append({
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "   ",
    highlight = { colors.blue, colors.bg },
  },
})
-- lsp diagnostic = info
left_list:append({
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "   ",
    highlight = { colors.orange, colors.bg },
  },
})
-- lsp status
left_list:append({
  CocStatus = {
    provider = function()
      return vim.api.nvim_eval("get(g:, 'coc_status', '')")
    end,
    icon = "   🗱",
    highlight = { colors.green, colors.bg },
  },
})
-- current function
-- left_list:append({
-- 	CocFunc = {
-- 		provider = function()
-- 			return "    " .. vim.api.nvim_eval("get(b:, 'coc_current_function', '')")
-- 		end,
-- 		highlight = { colors.yellow, colors.bg },
-- 	},
-- })

-- git blame
right_list:append({
  GitBlame = {
    provider = function()
      local msg = vim.api.nvim_eval("get(b:, 'coc_git_blame', '')")
      if msg == "" then
        return ""
      end
      if #msg > 70 then
        msg = msg:sub(0, 70) .. "... "
      end
      return msg .. " "
    end,
    icon = " ",
    highlight = { colors.purple, colors.line_bg },
  },
})

-- line/column
right_list:append({
  LineInfo = {
    provider = function()
      return string.format("%3d·%2d", vim.fn.line("."), vim.fn.col("."))
    end,
    highlight = { colors.fg, colors.line_bg },
  },
})
-----------------------------------------------------------

short_left_list:append({
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.magenta, colors.bg, "bold" },
  },
})

short_left_list:append({
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg, "bold" },
  },
})

short_right_list:append({
  BufferIcon = {
    provider = "BufferIcon",
    highlight = { colors.fg, colors.bg },
  },
})

------------------------------------
for idx, item in ipairs(left_list) do
  gls.left[idx] = item
end
for idx, item in ipairs(right_list) do
  gls.right[idx] = item
end
for idx, item in ipairs(short_left_list) do
  gls.short_line_left[idx] = item
end
for idx, item in ipairs(short_right_list) do
  gls.short_line_right[idx] = item
end
