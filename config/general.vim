" >>> general
set encoding=utf-8
set nu
set title
set lazyredraw
set nowrap
set foldenable
set ttyfast
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent 
set expandtab
set cc=80
set mouse=a 
set cursorline
set showmatch
set timeoutlen=500
set hlsearch
set scrolloff=5 
set ignorecase
set smartcase

" >> autocmd
autocmd FileType js,javascript,html,css,dart,yaml,json,xml,vue,rst,vim
        \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 

autocmd FileType python nmap <Leader>r :!python % <CR>

set rnu
augroup relative_numbers
autocmd!
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
augroup END

" autocmd BufReadPost *
"     \ if line("'\"") > 1 && line("'\"") <= line("$") |
"     \   exe 'normal! g`\"' |
"     \ endif

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

