local uv, api = vim.loop, vim.api

local stdin = uv.new_pipe(true)
local stdout = uv.new_pipe(false)
local stderr = uv.new_pipe(false)

local format = function()
  if vim.bo.filetype ~= "go" then
    return
  end

  local file_path = api.nvim_buf_get_name(0)
  local old_lines = api.nvim_buf_get_lines(0, 0, -1, true)

  local handle, pid = uv.spawn("golines", {
    stdio = { stdin, stdout, stderr },
    args = { "--max-len=80", file_path },
  }, function(code, signal)
  end)

  stdout:read_start(vim.schedule_wrap(function(err, data)
    assert(not err, err)
    print("data", data)
    if data then
      print(data)
    end
  end))

  stderr:read_start(function(err, data)
    assert(not err, err)
    if data then
      print("stderr chunk", stderr, data)
    end
  end)

  stdin:shutdown(function()
    handle:close(function()
    end)
  end)
end

return { format = format }
