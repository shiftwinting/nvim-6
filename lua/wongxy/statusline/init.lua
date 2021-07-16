local _tables = require 'wongxy.statusline.tables'
local colors = _tables.colors
local mode_names = _tables.mode_names
local mode_colors = _tables.mode_colors
local mode_symbols = _tables.mode_symbols
local exceptions = _tables.exceptions
local fn = vim.fn
local api = vim.api

local bg_color = wxy.darken_color(wxy.hi_value('Normal', 'bg'), -11)

local function set_highlight()
  bg_color = wxy.darken_color(wxy.hi_value('Normal', 'bg'), -11)
  wxy.highlight_all {
    {
      'StatusLine',
      {
        guifg = wxy.hi_value('Normal', 'fg'),
        guibg = bg_color,
      },
    },
    { 'StatusLineIndicator', { guifg = colors.blue, guibg = bg_color } },
    -- StatusLineModeSymbol
    -- { "StatusLineModeName", { guifg = colors.fg } },
    { 'StatusLineFileIcon', { guifg = '#c2ccd0', guibg = bg_color } },
    {
      'StatusLineFilePath',
      { guifg = wxy.hi_value('Comment', 'fg'), guibg = bg_color, gui = 'italic' },
    },
    { 'StatusLineFileName', { guifg = colors.magenta, guibg = bg_color, gui = 'bold' } },
    -- { "StatusLineLocation", { guifg = colors.fg } },
    { 'StatusLineLspStatus', { guifg = colors.green, guibg = bg_color, gui = 'bold' } },
    { 'StatusLineDiagnosticHint', { guifg = colors.blue, guibg = bg_color } },
    { 'StatusLineDiagnosticInfo', { guifg = colors.cyan, guibg = bg_color } },
    { 'StatusLineDiagnosticWarn', { guifg = colors.yellow, guibg = bg_color } },
    { 'StatusLineDiagnosticError', { guifg = colors.red, guibg = bg_color } },
    { 'StatusLineDiffAdded', { guifg = colors.green, guibg = bg_color } },
    { 'StatusLineDiffModified', { guifg = colors.orange, guibg = bg_color } },
    { 'StatusLineDiffRemoved', { guifg = colors.red, guibg = bg_color } },
  }
end

local function mode_symbol()
  local mode = fn.mode()
  wxy.highlight('StatusLineModeSymbol', { guifg = mode_colors[mode], guibg = bg_color })
  return '%#StatusLineModeSymbol#' .. mode_symbols[mode]
end

local function mode_name()
  local mode = fn.mode()
  return '%#StatusLineModeName#' .. mode_names[mode]
end

local function file_icon()
  local name, icon = fn.bufname(), ''
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if ok then
    local icon_hi
    icon, icon_hi = devicons.get_icon(name, fn.fnamemodify(name, ':e'), { default = true })
    wxy.highlight('StatusLineFileIcon', { guifg = wxy.hi_value(icon_hi, 'fg'), guibg = bg_color })
  end
  return '%#StatusLineFileIcon#' .. icon
end

local function file_name()
  local name = fn.expand '%:t'
  if name == '' then
    return ''
  end

  local path = fn.expand '%:h'
  if path == '.' then
    path = ''
  else
    path = path .. PATH_SEP
  end

  local icon = ''
  if vim.bo.readonly then
    icon = ''
  elseif vim.bo.modified then
    icon = ''
  end

  return '%#StatusLineFilePath#' .. path .. '%#StatusLineFileName#' .. name .. ' ' .. icon
end

local diagnostic = (function()
  local levels = {
    error = 'Error',
    warning = 'Warning',
    information = 'Information',
    hint = 'Hint',
  }
  return function()
    local result = { error = 0, warning = 0, information = 0, hint = 0 }

    local info = vim.b.coc_diagnostic_info
    if type(info) == 'table' then
      result = info
    else
      if #vim.lsp.get_active_clients() > 0 then
        for key, level in pairs(levels) do
          result[key] = vim.lsp.diagnostic.get_count(api.nvim_get_current_buf(), level)
        end
      end
    end

    local signs = {}
    if result.error > 0 then
      table.insert(signs, '%#StatusLineDiagnosticError# ' .. result.error)
    end
    if result.warning > 0 then
      table.insert(signs, '%#StatusLineDiagnosticWarn# ' .. result.warning)
    end
    if result.information > 0 then
      table.insert(signs, '%#StatusLineDiagnosticInfo# ' .. result.information)
    end
    if result.hint > 0 then
      table.insert(signs, '%#StatusLineDiagnosticHint# ' .. result.hint)
    end
    return table.concat(signs, ' ')
  end
end)()

local function lsp_status()
  local status = vim.trim(vim.g.coc_status or '')
  return status == '' and '' or '%#StatusLineLspStatus# ' .. status
end

local git_diff = (function()
  wxy.autocmd {
    {
      { 'BufEnter', 'BufWritePost', 'BufRead' },
      function()
        if #fn.expand '%' == 0 then
          return
        end
        fn.jobstart(
          string.format(
            [[git -C %s --no-pager diff --no-color --no-ext-diff -U0 -- %s]],
            fn.expand '%:h',
            fn.expand '%:t'
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
                      mod_count = tokens[3] == '' and 1 or tonumber(tokens[3]),
                      new_count = tokens[5] == '' and 1 or tonumber(tokens[5]),
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
      '*',
    },
  }
  return function()
    local signs = {}
    local added, modified, removed = unpack(vim.g.git_diff or { 0, 0, 0 })
    if added > 0 then
      table.insert(signs, '%#StatusLineDiffAdded# ' .. added)
    end
    if modified > 0 then
      table.insert(signs, '%#StatusLineDiffModified# ' .. modified)
    end
    if removed > 0 then
      table.insert(signs, '%#StatusLineDiffRemoved# ' .. removed)
    end
    if #signs > 0 then
      return table.concat(signs, ' ')
    end
    return ''
  end
end)()

local os_name = (function()
  local name = ''
  if IS_LINUX then
    name = ''
  elseif IS_WINDOWS then
    name = ''
  elseif IS_MAC then
    name = ''
  end
  return name
end)()

local spacer = ' '

---@return string
local function build_status(...)
  local secs = {}
  for _, item in ipairs { ... } do
    if type(item) == 'function' then
      table.insert(secs, item())
    else
      table.insert(secs, item)
    end
  end
  return table.concat(secs, ' ')
end

_G.statusline = function()
  local status = ''

  local curwin = vim.g.statusline_winid or 0
  local curbuf = vim.api.nvim_win_get_buf(curwin)
  local bufname = fn.bufname(curbuf)
  local filetype = vim.bo[curbuf].filetype

  if exceptions.filetypes[filetype] then
    status = build_status('%#StatusLine#', exceptions.filetypes[filetype] .. ' ' .. bufname)
  elseif api.nvim_get_current_win() == curwin then
    status = build_status(
      '%#StatusLineIndicator#▌',
      -- left
      mode_symbol,
      mode_name,
      spacer,
      file_icon,
      file_name,
      '%#StatusLineLocation#%3l:%-2c',
      diagnostic,
      spacer,
      lsp_status,
      -- right
      '%=',
      git_diff,
      '%#StartsLine#' .. (filetype == '' and 'PlainText' or filetype:upper()),
      os_name,
      os.date '%H:%M',
      '%#StatusLineIndicator#▌'
    )
  else
    status = build_status('%#StatusLine#', bufname)
  end

  return status
end

wxy.autocmd {
  {
    'ColorScheme',
    function()
      vim.defer_fn(set_highlight, 200)
    end,
    '*',
  },
}

vim.o.statusline = '%!v:lua.statusline()'
