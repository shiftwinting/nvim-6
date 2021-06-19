local _tables = require("statusline.tables")
local colors = _tables.colors
local mode_names = _tables.mode_names
local mode_colors = _tables.mode_colors
local mode_symbols = _tables.mode_symbols
local exceptions = _tables.exceptions
local fn = vim.fn
local api = vim.api

wxy.highlight_all({
  { "StatusLine", { guifg = colors.fg, guibg = colors.bg } },
  { "StatusLineIndicator", { guifg = colors.blue } },
  -- StatusLineModeSymbol
  { "StatusLineModeName", { guifg = colors.fg } },
  { "StatusLineModeName", { guifg = colors.fg } },
  -- StatusLineFileIcon
  { "StatusLineFileName", { guifg = colors.magenta, gui = "bold" } },
  { "StatusLineLocation", { guifg = colors.fg } },
  { "StatusLineCocStatus", { guifg = colors.green, gui = "bold" } },
  { "StatusLineCocDiagnosticHint", { guifg = colors.blue } },
  { "StatusLineCocDiagnosticInfo", { guifg = colors.cyan } },
  { "StatusLineCocDiagnosticWarn", { guifg = colors.yellow } },
  { "StatusLineCocDiagnosticError", { guifg = colors.red } },
})

local function mode_symbol()
  local mode = fn.mode()
  wxy.highlight("StatusLineModeSymbol", { guifg = mode_colors[mode], guibg = colors.bg })
  return "%#StatusLineModeSymbol#" .. mode_symbols[mode]
end

local function mode_name()
  local mode = fn.mode()
  return "%#StatusLineModeName#" .. mode_names[mode]
end

local function file_icon()
  local icon = ""
  vim.cmd("hi! StatusLineFileIcon guifg=#c2ccd0")
  if #vim.bo.filetype > 0 then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local icon_hi
      icon, icon_hi = devicons.get_icon(
        vim.fn.expand("%:t"),
        vim.fn.expand("%:e"),
        { default = true }
      )
      vim.cmd("hi! link StatusLineFileIcon " .. icon_hi)
    end
  end
  return "%#StatusLineFileIcon#" .. icon
end

local function file_name()
  local path = vim.fn.expand("%:~:.")
  if path == "" then
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
  return "%#StatusLineFileName#" .. path .. " " .. icon
end

local function coc_diagnostic()
  local ret = ""
  local info = vim.b.coc_diagnostic_info
  if info then
    local signs = {}
    if info.error > 0 then
      table.insert(signs, "%#StatusLineCocDiagnosticError# " .. info.error)
    end
    if info.warning > 0 then
      table.insert(signs, "%#StatusLineCocDiagnosticWarn# " .. info.warning)
    end
    if info.information > 0 then
      table.insert(signs, "%#StatusLineCocDiagnosticInfo# " .. info.information)
    end
    if info.hint > 0 then
      table.insert(signs, "%#StatusLineCocDiagnosticHint# " .. info.hint)
    end
    ret = " " .. table.concat(signs, " ")
  end
  return ret
end

local function coc_status()
  local status = vim.trim(vim.g.coc_status or "")
  return status == "" and "" or "%#StatusLineCocStatus# " .. status
end

-- local function fileformat(bufnr)
--   local icon
--   if vim.bo[bufnr].fileformat == "unix" then
--     icon = jit.os == "OSX" and "" or "ﱦ"
--   else
--     icon = ""
--   end
--   return "%#StatusLine#" .. icon
-- end

_G.statusline = function()
  local secs = {}
  local function ins(sec)
    table.insert(secs, sec)
  end

  local curwin = vim.g.statusline_winid or 0
  local curbuf = vim.api.nvim_win_get_buf(curwin)
  local bufname = fn.bufname(curbuf)
  local filetype = vim.bo[curbuf].filetype

  if exceptions.filetypes[filetype] then
    ins(exceptions.filetypes[filetype] .. " " .. bufname)
  elseif api.nvim_get_current_win() == curwin then
    ins("%#StatusLineIndicator#▌")
    -- left
    ins(mode_symbol())
    ins(mode_name())
    ins(" ")
    ins(file_icon())
    ins(file_name())
    ins("%#StatusLineLocation#%3l:%-3L")
    ins(coc_diagnostic())
    ins(" ")
    ins(coc_status())
    -- right
    ins("%=")
    -- ins(fileformat(0))
    local os_name = ""
    if IS_LINUX then
      os_name = "ﱦ"
    elseif IS_WINDOWS then
      os_name = ""
    elseif IS_MAC then
      os_name = ""
    end
    ins("%#StatusLine#" .. os_name)
    ins("%#StatusLine# " .. os.date("%H:%M"))
    ins("%#StatusLineIndicator#▌")
  else
    ins(bufname)
  end

  return table.concat(secs, " ")
end

local function setup()
  vim.o.statusline = "%!v:lua.statusline()"
end

setup()
