_G.wxy = {}

_G.HOME = os.getenv("HOME") .. "/"
_G.OS = vim.loop.os_uname().sysname
_G.IS_MAC = os_name == "Darwin"
_G.IS_LINUX = os_name == "Linux"
_G.IS_WINDOWS = os_name == "Windows"
_G.CONFIG_PATH = vim.fn.stdpath("config") .. "/"
_G.CACHE_PATH = HOME .. "/.cache/nvim/"
_G.DATA_PATH = vim.fn.stdpath("data") .. "/site/"

require("globals.keybind")
require("globals.autocmd")
require("globals.highlight")
require("globals.utils")

-------------------------------

local fn = vim.fn

if vim.notify then
  ---Override of vim.notify to open floating window
  --@param message of the notification to show to the user
  --@param log_level Optional log level
  --@param opts Dictionary with optional options (timeout, etc)
  vim.notify = function(message, log_level, _)
    assert(message, "The message key of vim.notify should be a string")
    wxy.notify(message, { timeout = 5000, log_level = log_level })
  end
end
