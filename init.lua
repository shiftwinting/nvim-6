_G.vim = vim

vim.cmd 'syntax enable'

require 'wongxy.globals'
require 'wongxy.options'
require 'wongxy.plugins'
require 'wongxy.statusline'

-- load local profile
pcall(vim.cmd, 'source  profile.vim')
pcall(vim.cmd, 'luafile profile.lua')
