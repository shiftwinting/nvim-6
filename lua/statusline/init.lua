local _tables = require("statusline.tables")
local colors = _tables.colors
local mode_names = _tables.mode_names
local mode_colors = _tables.mode_colors
local mode_symbols = _tables.mode_symbols
local exceptions = _tables.exceptions
local fn = vim.fn
local api = vim.api

local function set_highlight()
  wxy.highlight_all({
    { "StatusLine", { guifg = wxy.hi_value("Normal", "fg"), guibg = wxy.hi_value("Normal", "bg") } },
    { "StatusLineIndicator", { guifg = colors.blue } },
    -- StatusLineModeSymbol
    -- { "StatusLineModeName", { guifg = colors.fg } },
    { "StatusLineFileIcon", { guifg = "#c2ccd0" } },
    { "StatusLineFileName", { guifg = colors.magenta, gui = "bold" } },
    -- { "StatusLineLocation", { guifg = colors.fg } },
    { "StatusLineCocStatus", { guifg = colors.green, gui = "bold" } },
    { "StatusLineCocDiagnosticHint", { guifg = colors.blue } },
    { "StatusLineCocDiagnosticInfo", { guifg = colors.cyan } },
    { "StatusLineCocDiagnosticWarn", { guifg = colors.yellow } },
    { "StatusLineCocDiagnosticError", { guifg = colors.red } },
    { "StatusLineDiffAdded", { guifg = colors.green } },
    { "StatusLineDiffModified", { guifg = colors.orange } },
    { "StatusLineDiffRemoved", { guifg = colors.red } },
  })
end

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
  local name, icon = fn.bufname(), ""
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local icon_hi
    icon, icon_hi = devicons.get_icon(name, fn.fnamemodify(name, ":e"), { default = true })
    vim.cmd("hi! link StatusLineFileIcon " .. icon_hi)
  end
  return "%#StatusLineFileIcon#" .. icon
end

local function file_name()
  local path = fn.expand("%:~:.")
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

local git_diff = (function()
  wxy.autocmd({
    {
      { "BufEnter", "BufWritePost", "BufRead" },
      function()
        if #fn.expand("%") == 0 then
          return
        end
        fn.jobstart(
          string.format(
            [[git -C %s --no-pager diff --no-color --no-ext-diff -U0 -- %s]],
            fn.expand("%:h"),
            fn.expand("%:t")
          ),
          {
            stdout_buffered = true,
            on_stdout = function(_, data, _)
              if data then
                -- process diff data
                -- from lualine.nvim
                local added, modified, removed = 0, 0, 0
                for _, line in ipairs(data) do
                  if string.find(line, [[^@@ ]]) then
                    local tokens = vim.fn.matchlist(line, [[^@@ -\v(\d+),?(\d*) \+(\d+),?(\d*)]])
                    local line_stats = {
                      mod_count = tokens[3] == "" and 1 or tonumber(tokens[3]),
                      new_count = tokens[5] == "" and 1 or tonumber(tokens[5]),
                    }

                    if line_stats.mod_count == 0 and line_stats.new_count > 0 then
                      added = added + line_stats.new_count
                    elseif line_stats.mod_count > 0 and line_stats.new_count == 0 then
                      removed = removed + line_stats.mod_count
                    else
                      local min = math.min(line_stats.mod_count, line_stats.new_count)
                      modified = modified + min
                      added = added + line_stats.new_count - min
                      removed = removed + line_stats.mod_count - min
                    end
                  end
                end
                vim.g.git_diff = { added, modified, removed }
              end
            end,
          }
        )
      end,
      "*",
    },
  })
  return function()
    local signs = {}
    local added, modified, removed = unpack(vim.g.git_diff or { 0, 0, 0 })
    if added > 0 then
      table.insert(signs, "%#StatusLineDiffAdded# " .. added)
    end
    if modified > 0 then
      table.insert(signs, "%#StatusLineDiffModified# " .. modified)
    end
    if removed > 0 then
      table.insert(signs, "%#StatusLineDiffRemoved# " .. removed)
    end
    if #signs > 0 then
      return table.concat(signs, " ")
    end
    return ""
  end
end)()

local os_name = (function()
  local name = ""
  if IS_LINUX then
    name = "ﱦ"
  elseif IS_WINDOWS then
    name = ""
  elseif IS_MAC then
    name = ""
  end
  return name
end)()

local spacer = " "

---@return string
local function build_status(...)
  local secs = {}
  for _, item in ipairs({ ... }) do
    if type(item) == "function" then
      table.insert(secs, item())
    else
      table.insert(secs, item)
    end
  end
  return table.concat(secs, " ")
end

_G.statusline = function()
  local status = ""

  local curwin = vim.g.statusline_winid or 0
  local curbuf = vim.api.nvim_win_get_buf(curwin)
  local bufname = fn.bufname(curbuf)
  local filetype = vim.bo[curbuf].filetype

  if exceptions.filetypes[filetype] then
    status = build_status("%#StatusLine#", exceptions.filetypes[filetype] .. " " .. bufname)
  elseif api.nvim_get_current_win() == curwin then
    status = build_status(
      "%#StatusLine#",
      "%#StatusLineIndicator#▌",
      -- left
      mode_symbol,
      mode_name,
      spacer,
      file_icon,
      file_name,
      "%#StatusLineLocation#%3l:%-2c",
      coc_diagnostic,
      spacer,
      coc_status,
      -- right
      "%=",
      git_diff,
      "%#StatusLine#" .. os_name,
      "%#StatusLine# " .. os.date("%H:%M"),
      "%#StatusLineIndicator#▌"
    )
  else
    status = build_status("%#StatusLine#", bufname)
  end

  return status
end

local function setup()
  vim.o.statusline = "%!v:lua.statusline()"
end

set_highlight()
setup()

wxy.autocmd({ {
  "ColorScheme",
  set_highlight,
  "*",
} })
