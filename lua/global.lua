local home = os.getenv("HOME")
local os_name = vim.loop.os_uname().sysname
local is_mac = os_name == "Darwin"
local is_linux = os_name == "Linux"
local is_windows = os_name == "Windows"
local path_sep = is_windows and "\\" or "/"
local vim_path = vim.fn.stdpath("config") .. path_sep
local cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep
local config_dir = vim_path .. "lua/config" .. path_sep
local data_dir = string.format("%s/site/", vim.fn.stdpath("data"))

return {
  home = home,
  os_name = os_name,
  is_mac = is_mac,
  is_linux = is_linux,
  is_windows = is_windows,
  path_sep = path_sep,
  vim_path = vim_path,
  cache_dir = cache_dir,
  config_dir = config_dir,
  data_dir = data_dir,
}
