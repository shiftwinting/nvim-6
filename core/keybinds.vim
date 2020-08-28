" > normal
nnoremap zz :x<CR>

nnoremap <silent> <leader>s :w<cr>

nnoremap <silent> <leader>h :nohl<CR>

nnoremap s <nop>

noremap Y y$

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <silent> <leader>p "+p

nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" > insert
inoremap jj <Esc>`^

inoremap <C-l> <C-o>A
inoremap <C-j> <C-o>o
inoremap <C-k> <C-o>O

inoremap <C-w> <up>
inoremap <C-a> <left>
inoremap <C-s> <down>
inoremap <C-d> <right>

