local global = require("global")
local utils = require("utils")
local autocmd = utils.autocmd

autocmd("common", {
  -- Reload vim config automatically
  -- FIXME
  -- string.format([[BufWritePost %s{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]], global.vim_path),
  -- Reload Vim script automatically if setlocal autoread
  [[BufWritePost,FileWritePost *.vim nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
  -- Update filetype on save if empty
  [[BufWritePost * nested if &l:filetype ==# '' || exists('b:ftdetect') | unlet! b:ftdetect | filetype detect | endif]],
  -- Highlight current line only on focused window
  [[WinEnter,InsertLeave * if &ft !~# '^\(denite\|clap_\)' | set cursorline | endif]],
  [[WinLeave,InsertEnter * if &ft !~# '^\(denite\|clap_\)' | set nocursorline | endif]],
  -- Automatically set read-only for files being edited elsewhere
  [[SwapExists * nested let v:swapchoice = 'o']],
  -- Equalize window dimensions when resizing vim window
  [[VimResized * tabdo wincmd =]],
  -- Force write shada on leaving nvim
  [[VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif]],
  -- Check if file changed when its window is focus, more eager than 'autoread'
  [[FocusGained * checktime]],

  [[BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],

  [[Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif]],
}, true)

-- Automatically set relativenumber
vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
vim.cmd([[autocmd InsertLeave * :set relativenumber]])

-- Automatically set cursorline
vim.cmd([[autocmd InsertLeave,WinEnter * set cursorline]])
vim.cmd([[autocmd InsertEnter,WinLeave * set nocursorline]])

-- Detect filetype
vim.cmd([[autocmd BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc]])
vim.cmd([[autocmd BufNewFile,BufRead go.mod            setlocal filetype=gomod]])

vim.cmd([[autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')]])

-- using golines to format go code
vim.cmd([[autocmd BufWritePre *.go :lua require('golines').golines_format()]])

-- Auto cache/clean colorscheme/highlight
vim.cmd([[autocmd ColorScheme * lua require('colorscheme').cache_theme()]])
vim.cmd([[autocmd ColorSchemePre * lua require('colorscheme').clean()]])
