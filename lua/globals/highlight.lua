wxy.highlight = function(name, opts, clear)
  clear = clear or false
  local cmd = {}
  if type(opts) == "string" then
    cmd = { "highlight" .. (clear and "!" or ""), "link", name, opts }
  else
    cmd = { "highlight" .. (clear and "!" or ""), name }
    for k, v in pairs(opts) do
      table.insert(cmd, k .. "=" .. v)
    end
  end

  local ok, msg = pcall(vim.cmd, table.concat(cmd, " "))
  if not ok then
    vim.notify(string.format("Failed to set %s because: %s", name, msg))
  end
end

wxy.highlight_all = function(hls)
  for _, hl in ipairs(hls) do
    wxy.highlight(unpack(hl))
  end
end