---Create an nvim command
---@param args table
function wxy.command(args)
  local nargs = args.nargs or 0
  local name = args[1]
  local rhs = args[2]
  local types = (args.types and type(args.types) == 'table') and table.concat(args.types, ' ') or ''

  if type(rhs) == 'function' then
    local fn_id = wxy._create(rhs)
    rhs = string.format('lua wxy._execute(%d%s)', fn_id, nargs > 0 and ', <f-args>' or '')
  end

  vim.cmd(string.format('command! -nargs=%s %s %s %s', nargs, types, name, rhs))
end
