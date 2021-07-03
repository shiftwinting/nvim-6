local Map = {}

function Map:new()
  local instance = {
    rhs = "",
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
  self.rhs = (":%s<CR>"):format(cmd_string)
  return self
end

function Map:args(cmd_string)
  self.rhs = (":%s<Space>"):format(cmd_string)
  return self
end

function Map:cu(cmd_string)
  self.rhs = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

--@param callback function
function Map:fn(callback)
  self.rhs = string.format(":<C-u>lua wxy._execute(%s)<CR>", wxy._create(callback))
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

---------------------------------------------

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
      local modes, lhs = key:match("([^|]*)|?(.*)")
      for idx = 1, #modes do
        vim.api.nvim_set_keymap(modes:sub(idx, idx), lhs, map.rhs, map.opts)
      end
    end
  end,
}
