_G.vim = vim

vim.cmd("syntax enable")

vim.cmd("augroup vimrc | autocmd! | augroup END")

require("core")
