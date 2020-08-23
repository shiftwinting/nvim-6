" >>> sbdchd/neoformat
nnoremap <F6> :Neoformat<CR>
nnoremap ,ff :Neoformat<CR>
let g:neoformat_enabled_python = ['autopep8', 'yapf']
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * Neoformat
" augroup END

