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

require 'wongxy.globals.keybind'
require 'wongxy.globals.autocmd'
require 'wongxy.globals.highlight'
require 'wongxy.globals.utils'
require 'wongxy.globals.command'
