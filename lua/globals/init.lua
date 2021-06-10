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
require("globals.utils")
