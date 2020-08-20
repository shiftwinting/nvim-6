" ======================================="
"  vim/neovim's configuration of wongxy. "
" ======================================="

" >>> junegunn/vim-plug
if has('nvim')
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://cdn.jsdelivr.net/gh/junegunn/vim-plug/plug.vim
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://cdn.jsdelivr.net/gh/junegunn/vim-plug/plug.vim
  endif
endif

call plug#begin('~/.vim/plugged')
" colorschemes
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'

Plug 'easymotion/vim-easymotion'
Plug 'lfv89/vim-interestingwords'
Plug 'itchyny/vim-cursorword'
Plug 'tpope/vim-speeddating'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'hardcoreplayers/dashboard-nvim', { 'frozen': 1 }
Plug 'honza/vim-snippets'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'aserebryakov/vim-todo-lists'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye'
Plug 'voldikss/vim-floaterm'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}
Plug 'wsdjeg/vim-lua', { 'for': 'lua' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
call plug#end()


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
autocmd FileType python nmap <Leader>r :!time python % <CR>

set rnu
augroup relative_numbers
autocmd!
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
augroup END

autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" >> mappings
let mapleader=','
let g:mapleader=','

" > normal
nnoremap <leader>e ZZ
 
nnoremap <silent> <leader>s :w<cr>

nnoremap <silent> <leader>h :nohl<CR>

nnoremap <silent> [b :bp<CR>
nnoremap <silent> [n :bn<CR>

nnoremap s <nop>

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

" > command
cnoremap w!! w !sudo tee % >/dev/null


" >>> colorscheme
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

colorscheme hybrid_reverse
" hybrid material
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:hybrid_transparent_background = 1
let g:enable_bold_font = 0
let g:enable_italic_font = 1
" one
let g:one_allow_italics = 1


" >>> fatih/vim-go
" https://github.com/fatih/vim-go-tutorial
let g:go_version_warning = 0
set autowrite
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>d  <Plug>(go-def)
let g:go_list_type = "quickfix"
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['golint']
let g:go_metalinter_autosave = 0 


" >>> dart-lang/dart-vim-plugin
autocmd BufWritePre *.dart* DartFmt


" >>> suan/vim-instant-markdown
let g:instant_markdown_autostart = 0


" >>> Yggdroot/indent-line
let g:indentLine_fileTypeExclude = ['dashboard']


" >>> hardcoreplayers/dashboard-nvim
let g:dashboard_default_executive ='fzf'
nmap <space>ss :<C-u>SessionSave<CR>
nmap <space>sl :<C-u>SessionLoad<CR>
nmap <space>nf :<C-u>DashboardNewFile<CR>
nnoremap <silent> <space>fh :History<CR>
nnoremap <silent> <space>ff :Files<CR>
nnoremap <silent> <space>tc :Colors<CR>
nnoremap <silent> <space>fa :Rg<CR>
nnoremap <silent> <space>fb :Marks<CR>

let g:dashboard_custom_shortcut={
  \ 'new_file':           'SPC n f',
  \ 'last_session':       'SPC s l',
  \ 'find_history':       'SPC f h',
  \ 'find_file':          'SPC f f',
  \ 'change_colorscheme': 'SPC t c',
  \ 'find_word':          'SPC f a',
  \ 'book_marks':         'SPC f b',
  \ }


" >>> Shougo/defx.nvim
nnoremap <silent> <Leader>t :Defx<CR>

call defx#custom#option('_', {
	\ 'resume': 1,
  \ 'toggle': 1,
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'columns': 'indent:git:icons:filename',
	\ 'root_marker': '',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
	\ })

call defx#custom#column('git', {
	\   'indicators': {
	\     'Modified'  : 'Ⅿ',
	\     'Staged'    : '✚',
	\     'Untracked' : 'U',
	\     'Renamed'   : '➜',
	\     'Unmerged'  : '≠',
	\     'Ignored'   : 'ⁱ',
	\     'Deleted'   : '✗',
	\     'Unknown'   : '?'
	\   }
	\ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })
call defx#custom#column('filename', { 'root_marker_highlight': 'Comment' })

" defx-icons plugin
let g:defx_icons_column_length = 2
let g:defx_icons_mark_icon = ''

autocmd FileType defx call s:defx_settings()

function! s:defx_settings() abort
  setl nospell
  setl signcolumn=no
  setl nonumber
  nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> o defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> q      defx#do_action('quit')
  nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
  nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
  nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
  nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
  nnoremap <silent><buffer><expr> dd defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N  defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> s defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> <Tab> <SID>defx_toggle_zoom()
endfunction

function s:defx_toggle_zoom() abort
    let b:DefxOldWindowSize = get(b:, 'DefxOldWindowSize', winwidth('%'))
    let size = b:DefxOldWindowSize
    if exists("b:DefxZoomed") && b:DefxZoomed
        exec "silent vertical resize ". size
        let b:DefxZoomed = 0
    else
        exec "vertical resize ". get(g:, 'DefxWinSizeMax', '')
        let b:DefxZoomed = 1
    endif
endfunction


" >>> voldikss/vim-floaterm
" let g:floaterm_keymap_new    = '<F7>'
" let g:floaterm_keymap_prev   = '<F8>'
" let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'


" >>> moll/vim-bbye
"  Bdelete : Ctrl-o will reopen the file. (Bwipeout)
nnoremap <silent> \\ :Bdelete<CR>


" >>> dense-analysis/ale
let g:ale_sign_error = '😭'
let g:ale_sign_warning = '👻'


" >>> junegunn/fzf.vim
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <c-p> :Files<CR>


" >>> junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" >>> majutsushi/tagbar
nmap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0    " sort by sourcefile
"let g:tagbar_show_linenumbers = 1
set updatetime=1000    " ms update


" >>> easymotion/vim-easymotion
nmap ss <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)


" >>> sbdchd/neoformat
nnoremap <F6> :Neoformat<CR>
nnoremap ,ff :Neoformat<CR>
let g:neoformat_enabled_python = ['autopep8', 'yapf']
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * Neoformat
" augroup END


" >>> kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
                    \ ['brown',       'RoyalBlue3'],
                    \ ['Darkblue',    'SeaGreen3'],
                    \ ['darkgray',    'DarkOrchid3'],
                    \ ['darkgreen',   'firebrick3'],
                    \ ['darkcyan',    'RoyalBlue3'],
                    \ ['darkred',     'SeaGreen3'],
                    \ ['darkmagenta', 'DarkOrchid3'],
                    \ ['brown',       'firebrick3'],
                    \ ['gray',        'RoyalBlue3'],
                    \ ['darkmagenta', 'DarkOrchid3'],
                    \ ['Darkblue',    'firebrick3'],
                    \ ['darkgreen',   'RoyalBlue3'],
                    \ ['darkcyan',    'SeaGreen3'],
                    \ ['darkred',     'DarkOrchid3'],
                    \ ['red',         'firebrick3'],
                    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" >>> vim-airline/vim-airline
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
function! ArilineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%F'])
    "let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l', '%c'])
endfunction
autocmd VimEnter * call ArilineInit()


" >>> neoclide/coc.nvim
call coc#add_extension(
            \'coc-clangd',
            \'coc-css',
            \'coc-emmet',
            \'coc-eslint',
            \'coc-flutter',
            \'coc-highlight',
            \'coc-html',
            \'coc-json',
            \'coc-lua',
            \'coc-prettier',
            \'coc-python', 
            \'coc-rust-analyzer',
            \'coc-snippets',
            \'coc-translator',
            \'coc-tsserver',
            \'coc-vetur',
            \'coc-yaml',
            \)
inoremap <silent><expr> <C-q> coc#refresh()
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '😭'
let airline#extensions#coc#warning_symbol = '👻'
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if has('patch8.1.1068')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')

command! -nargs=? Fold :call CocAction('fold', <f-args>)

command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" >>> configurations for coc extensions
" >> coc-translator
nmap tt <Plug>(coc-translator-p)
vmap tt <Plug>(coc-translator-pv)


" >>> other
let profile_path = '~/.config/nvim/profile.vim'
if filereadable(expand(profile_path))
    exe 'source' profile_path
endif
