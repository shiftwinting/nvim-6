_G.vim = vim

vim.cmd 'syntax enable'

require 'wongxy.globals'
require 'wongxy.options'
require 'wongxy.plugins'
require 'wongxy.statusline'

-- load local profile
pcall(vim.cmd, 'source ' .. CONFIG_PATH .. 'profile.vim')
pcall(vim.cmd, 'luafile ' .. CONFIG_PATH .. 'profile.lua')
