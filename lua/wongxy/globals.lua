_G.wxy = {}

_G.PATH_SEP = package.config:sub(1, 1)
_G.HOME = os.getenv 'HOME' .. '/'
_G.OS = vim.loop.os_uname().sysname
_G.IS_MAC = OS == 'Darwin'
_G.IS_LINUX = OS == 'Linux'
_G.IS_WINDOWS = OS:find 'Windows'
_G.CONFIG_PATH = vim.fn.stdpath 'config' .. '/'
_G.CACHE_PATH = HOME .. '/.cache/nvim/'
_G.DATA_PATH = vim.fn.stdpath 'data' .. '/site/'

wxy._callbacks = {}

wxy._create = function(f)
  table.insert(wxy._callbacks, f)
  return #wxy._callbacks
end

wxy._execute = function(id, args)
  wxy._callbacks[id](args)
end

local api = vim.api
local fn = vim.fn
local fmt = string.format

-------------------------------
-- Keybind
-------------------------------

local Map = {}

function Map:new()
  local instance = {
    rhs = '',
    opts = {
      noremap = false,
      silent = false,
      expr = false,
      nowait = false,
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

--- build rhs

function Map:cmd(cmd_string)
  self.rhs = cmd_string
  return self
end

function Map:cr(cmd_string)
  self.rhs = (':%s<CR>'):format(cmd_string)
  return self
end

function Map:args(cmd_string)
  self.rhs = (':%s<Space>'):format(cmd_string)
  return self
end

function Map:cu(cmd_string)
  self.rhs = (':<C-u>%s<CR>'):format(cmd_string)
  return self
end

--@param callback function
function Map:fn(callback)
  self.rhs = fmt(':<C-u>lua wxy._execute(%s)<CR>', wxy._create(callback))
  return self
end

--- set options

function Map:silent()
  self.opts.silent = not self.opts.silent
  return self
end

function Map:noremap()
  self.opts.noremap = not self.opts.noremap
  return self
end

function Map:expr()
  self.opts.expr = not self.opts.expr
  return self
end

function Map:nowait()
  self.opts.nowait = not self.opts.nowait
  return self
end

--- must be called last
---@param key string: such as "n|j"
function Map:bind(key)
  local modes, lhs = key:match '([^|]*)|?(.*)'
  for idx = 1, #modes do
    vim.api.nvim_set_keymap(modes:sub(idx, idx), lhs, self.rhs, self.opts)
  end
end

wxy.keybind = {
  cmd = function(s)
    return Map:new():cmd(s)
  end,

  cu = function(s)
    return Map:new():cu(s)
  end,

  cr = function(s)
    return Map:new():cr(s)
  end,

  args = function(s)
    return Map:new():args(s)
  end,

  fn = function(c)
    return Map:new():fn(c)
  end,

  load_maps = function(mapping)
    for key, map in pairs(mapping) do
      map:bind(key)
    end
  end,
}

-------------------------------
-- autocmd
-------------------------------

-- viml: autocmd BufWritePre *.go echo 'go'
-- autocmd("BufWritePre *.go echo 'go'")
-- autocmd({'BufWritePre', "echo 'go'", '*.go'})
-- autocmd({'', {events, command, targets, modifiers}})
-- events: string/table
-- command: string/function
-- targets: nil/string/table
-- modifiers: nil/string/table
wxy.autocmd = function(commands)
  if type(commands) == 'string' then
    commands = { commands }
  end
  for _, c in ipairs(commands) do
    if type(c) == 'string' then
      vim.cmd('autocmd ' .. c)
    else
      local events = c[1]
      local command = c[2]
      local targets = c[3] or {}
      local modifiers = c[4] or {}
      if type(events) == 'string' then
        events = { events }
      end
      if type(targets) == 'string' then
        targets = { targets }
      end
      if type(modifiers) == 'string' then
        modifiers = { modifiers }
      end
      if type(command) == 'function' then
        local fn_id = wxy._create(command)
        command = fmt('lua wxy._execute(%s)', fn_id)
      end
      vim.cmd(
        fmt(
          'autocmd %s %s %s %s',
          table.concat(events, ','),
          table.concat(targets, ','),
          table.concat(modifiers, ' '),
          command
        )
      )
    end
  end
end

wxy.augroup = function(name, commands, clear)
  clear = clear == nil and false or clear
  vim.cmd('augroup ' .. name)
  if clear then
    vim.cmd 'autocmd!'
  end
  wxy.autocmd(commands)
  vim.cmd 'augroup END'
end

-------------------------------
-- Highlight
-------------------------------

wxy.highlight = function(name, opts, clear)
  clear = clear or false
  local cmd = {}
  if type(opts) == 'string' then
    cmd = { 'highlight' .. (clear and '!' or ''), 'link', name, opts }
  else
    cmd = { 'highlight' .. (clear and '!' or ''), name }
    for k, v in pairs(opts) do
      table.insert(cmd, k .. '=' .. v)
    end
  end

  local ok, msg = pcall(vim.cmd, table.concat(cmd, ' '))
  if not ok then
    vim.notify(fmt('Failed to set %s because: %s', name, msg))
  end
end

wxy.highlight_all = function(hls)
  for _, hl in ipairs(hls) do
    wxy.highlight(unpack(hl))
  end
end

wxy.hi_value = (function()
  local gui_attr = { 'underline', 'bold', 'undercurl', 'italic' }
  local attrs = { fg = 'foreground', bg = 'background' }
  ---get the color value of part of a highlight group
  ---@param grp string
  ---@param attr string
  ---@param fallback string
  ---@return string
  return function(grp, attr, fallback)
    if not grp then
      return vim.notify 'Cannot get a highlight without specifying a group'
    end
    attr = attrs[attr] or attr
    local hl = vim.api.nvim_get_hl_by_name(grp, true)
    if attr == 'gui' then
      local gui = {}
      for name, value in pairs(hl) do
        if value and vim.tbl_contains(gui_attr, name) then
          table.insert(gui, name)
        end
      end
      return table.concat(gui, ',')
    end
    local color = hl[attr] or fallback
    -- convert the decimal rgba value from the hl by name to a 6 character hex + padding if needed
    if not color then
      -- vim.notify(fmt("%s %s does not exist", grp, attr))
      return 'NONE'
    end
    return '#' .. bit.tohex(color, 6)
  end
end)()

---Convert a hex color to rgb
---@param color string
---@return number
---@return number
---@return number
local function hex_to_rgb(color)
  local hex = color:gsub('#', '')
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

---@source https://stackoverflow.com/q/5560248
---@see: https://stackoverflow.com/a/37797380
---Darken a specified hex color
---@param color string
---@param percent number
---@return string
wxy.darken_color = function(color, percent)
  local r, g, b = hex_to_rgb(color)
  if not r or not g or not b then
    return 'NONE'
  end
  r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
  r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
  return fmt('#%02x%02x%02x', r, g, b)
end

-------------------------------
-- Command
-------------------------------

---Create an nvim command
---@param args table
function wxy.command(args)
  local name = args[1]
  local rhs = args[2]
  local nargs = args.nargs or 0
  local types = (args.types and type(args.types) == 'table') and table.concat(args.types, ' ') or ''

  if type(rhs) == 'function' then
    local fn_id = wxy._create(rhs)
    rhs = fmt('lua wxy._execute(%d%s)', fn_id, nargs > 0 and ', <f-args>' or '')
  end

  vim.cmd(fmt('command! -nargs=%s %s %s %s', nargs, types, name, rhs))
end

-------------------------------
-- Utility
-------------------------------

------------ notification -------------

local function get_last_notification()
  for _, win in ipairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'vim-notify' and api.nvim_win_is_valid(win) then
      return api.nvim_win_get_config(win)
    end
  end
end

local notification_hl = setmetatable({
  [2] = { 'FloatBorder:NvimNotificationError', 'NormalFloat:NvimNotificationError' },
  [1] = { 'FloatBorder:NvimNotificationInfo', 'NormalFloat:NvimNotificationInfo' },
}, {
  __index = function(t, k)
    return k > 1 and t[2] or t[1]
  end,
})

---Utility function to create a notification message
---@param lines string[] | string
---@param opts table
function wxy.notify(lines, opts)
  lines = type(lines) == 'string' and { lines } or lines
  lines = vim.tbl_flatten(vim.tbl_map(function(line)
    return vim.split(line, '\n')
  end, lines))
  opts = opts or {}
  local highlights = { 'NormalFloat:Normal' }
  local level = opts.log_level or 1
  local timeout = opts.timeout or 5000

  local width
  for i, line in ipairs(lines) do
    line = '  ' .. line .. '  '
    lines[i] = line
    local length = #line
    if not width or width < length then
      width = length
    end
  end
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  local height = #lines
  local prev = get_last_notification()
  local row = prev and prev.row[false] - prev.height - 2 or vim.o.lines - vim.o.cmdheight - 3
  local win = api.nvim_open_win(buf, false, {
    relative = 'editor',
    width = width + 2,
    height = height,
    col = vim.o.columns - 2,
    row = row,
    anchor = 'SE',
    style = 'minimal',
    focusable = false,
    border = 'double',
  })

  local level_hl = notification_hl[level]

  vim.list_extend(highlights, level_hl)
  vim.wo[win].winhighlight = table.concat(highlights, ',')

  vim.bo[buf].filetype = 'vim-notify'
  vim.wo[win].wrap = true
  if timeout then
    vim.defer_fn(function()
      if api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
      end
    end, timeout)
  end
end

if vim.notify then
  ---Override of vim.notify to open floating window
  --@param message of the notification to show to the user
  --@param log_level Optional log level
  --@param opts Dictionary with optional options (timeout, etc)
  vim.notify = function(message, log_level, _)
    assert(message, 'The message key of vim.notify should be a string')
    wxy.notify(message, { timeout = 5000, log_level = log_level })
  end
end

------------------------------------------

---Check if a cmd is executable
---@param e string
---@return boolean
function wxy.executable(e)
  return fn.executable(e) > 0
end

---Check if directory exists using vim's isdirectory function
---@param path string
---@return boolean
function wxy.is_dir(path)
  return fn.isdirectory(path) > 0
end

---Determine if a value of any type is empty
---@param item any
---@return boolean
function wxy.empty(item)
  if not item then
    return true
  end
  local item_type = type(item)
  if item_type == 'string' then
    return item == ''
  elseif item_type == 'table' then
    return vim.tbl_isempty(item)
  end
end
