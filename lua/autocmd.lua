wxy.augroup("common", {
  -- Reload Vim script automatically if setlocal autoread
  [[BufWritePost,FileWritePost *.vim nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
  -- Update filetype on save if empty
  [[BufWritePost * nested if &l:filetype ==# '' || exists('b:ftdetect') | unlet! b:ftdetect | filetype detect | endif]],
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

  -- Automatically set relativenumber
  "InsertEnter * :set norelativenumber",
  "InsertLeave * :set relativenumber",
  -- Automatically set cursorline
  "InsertLeave,WinEnter * set cursorline",
  "InsertEnter,WinLeave * set nocursorline",
}, true)

wxy.autocmd({
  -- Detect filetype
  "BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc",
  "BufNewFile,BufRead go.mod            setlocal filetype=gomod",
})
