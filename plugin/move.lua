-- A wrapper of :move
local fn = vim.fn
local cmd = vim.cmd

local function move(first, last, dir)
  if not vim.bo.modifiable then
    return
  end

  first, last = fn.line(first), fn.line(last)

  local after
  if dir < 0 then
    -- down
    fn.cursor(first, 1)
    cmd('normal!' .. vim.v.count1 .. 'k')
    after = fn.line '.' - 1
  else
    -- up
    fn.cursor(last, 1)
    cmd('normal!' .. vim.v.count1 .. 'j')
    if fn.foldclosedend '.' == -1 then
      after = fn.line '.'
    else
      after = fn.foldclosedend '.'
    end
  end

  cmd(first .. ',' .. last .. 'move' .. after)
end

local function move_line_down()
  move('.', '.', 1)
end

local function move_line_up()
  move('.', '.', -1)
end

local function move_block_down()
  move("'<", "'>", 1)
  cmd 'normal!gv'
end

local function move_block_up()
  move("'<", "'>", -1)
  cmd 'normal!gv'
end

local map_fn = wxy.keybind.fn
wxy.keybind.load_maps {
  ['n|<A-j>'] = map_fn(move_line_down):noremap():silent(),
  ['n|<A-k>'] = map_fn(move_line_up):noremap():silent(),
  ['v|<A-j>'] = map_fn(move_block_down):noremap():silent(),
  ['v|<A-k>'] = map_fn(move_block_up):noremap():silent(),
}
