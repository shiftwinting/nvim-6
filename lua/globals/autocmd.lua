local cmd = vim.cmd
local fmt = string.format

wxy._store = {}

wxy._create = function(f)
  table.insert(wxy._store, f)
  return #wxy._store
end

wxy._execute = function(id, args)
  wxy._store[id](args)
end

-- viml: autocmd BufWritePre *.go echo 'go'
-- autocmd("BufWritePre *.go echo 'go'")
-- autocmd({'BufWritePre', "echo 'go'", '*.go'})
-- autocmd({'', {events, command, targets, modifiers}})
-- events: string/table
-- command: string/function
-- targets: nil/string/table
-- modifiers: nil/string/table
wxy.autocmd = function(commands)
  if type(commands) == "string" then
    commands = { commands }
  end
  for _, c in ipairs(commands) do
    if type(c) == "string" then
      cmd("autocmd " .. c)
    else
      local events = c[1]
      local command = c[2]
      local targets = c[3] or {}
      local modifiers = c[4] or {}
      if type(events) == "string" then
        events = { events }
      end
      if type(targets) == "string" then
        targets = { targets }
      end
      if type(modifiers) == "string" then
        modifiers = { modifiers }
      end
      if type(command) == "function" then
        local fn_id = wxy._create(command)
        command = fmt("lua wxy._execute(%s)", fn_id)
      end
      cmd(
        fmt(
          "autocmd %s %s %s %s",
          table.concat(events, ","),
          table.concat(targets, ","),
          table.concat(modifiers, " "),
          command
        )
      )
    end
  end
end

wxy.augroup = function(name, commands, clear)
  clear = clear == nil and false or clear
  cmd("augroup " .. name)
  if clear then
    cmd("autocmd!")
  end
  wxy.autocmd(commands)
  cmd("augroup END")
end
