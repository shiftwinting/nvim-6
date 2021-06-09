local utils = require("utils")
local augroup = utils.augroup
local autocmd = utils.autocmd

augroup("common", {
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

autocmd({
  -- Automatically set relativenumber
  "InsertEnter * :set norelativenumber",
  "InsertLeave * :set relativenumber",
  -- Automatically set cursorline
  "InsertLeave,WinEnter * set cursorline",
  "InsertEnter,WinLeave * set nocursorline",
  -- Detect filetype
  "BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc",
  "BufNewFile,BufRead go.mod            setlocal filetype=gomod",
  -- Auto cache/clean colorscheme/highlight
  "ColorScheme * lua require('colorscheme').cache_theme()",
  "ColorSchemePre * lua require('colorscheme').clean()",
})
