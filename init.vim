" -------------------------------------------------------------------------
"                                       _             _                    
" __      _____  _ __   __ ___  ___   _( )___  __   _(_)_ __ ___  _ __ ___ 
" \ \ /\ / / _ \| '_ \ / _` \ \/ / | | |// __| \ \ / / | '_ ` _ \| '__/ __|
"  \ V  V / (_) | | | | (_| |>  <| |_| | \__ \  \ V /| | | | | | | | | (__ 
"   \_/\_/ \___/|_| |_|\__, /_/\_\\__, | |___/   \_/ |_|_| |_| |_|_|  \___|
"                      |___/      |___/    
" -------------------------------------------------------------------------
set encoding=utf-8
set nu
set title
set lazyredraw " to avoid scrolling problems
set nowrap
set foldenable

" tab缩进有关
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
autocmd FileType js,html,css,dart,yaml,json,xml,vue,json 
            \setlocal tabstop=2 softtabstop=2 shiftwidth=2

set cc=99

" 自动对齐
set autoindent 

let autosave=2
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

" 高亮光标所在行、列
set cursorline
" set cursorcolumn

" 可以使用鼠标
set mouse=a 
set showmatch
set timeoutlen=500
set hlsearch
" keep 5 lines when scrolling
set scrolloff=5 


" ---------------------------------------
" - map
" ---------------------------------------
let mapleader=','
let g:mapleader=','

autocmd FileType python nmap <Leader>r :!time python % <CR>

" 插入模式自动切换相对行号
set rnu
augroup relative_numbers
autocmd!
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
augroup END

inoremap jj <Esc>`^

nnoremap EE ZZ
 
inoremap <silent> <leader>s <Esc>:w<cr>
nnoremap <silent> <leader>s :w<cr>

" 关闭搜索高亮
nnoremap <silent> <leader>h :nohl<CR>

" 切换buffer
nnoremap <silent> [b :bp<CR>
nnoremap <silent> [n :bn<CR>

" 不要s键功能
nnoremap s <nop>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


cnoremap w!! w !sudo tee % >/dev/null


" ---------------------------------------
" - vim-plug
" ---------------------------------------
call plug#begin('~/.vim/plugged')
    " Automatically install missing plugins on startup
    if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
      autocmd VimEnter * PlugInstall | q
    endif

    Plug 'honza/vim-snippets'     "CodInstall coc-snippets
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'w0ng/vim-hybrid'
    Plug 'rakr/vim-one'
    Plug 'morhetz/gruvbox'
    Plug 'altercation/vim-colors-solarized'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'rafi/awesome-vim-colorschemes'
    " 插件显示图标
    Plug 'ryanoasis/vim-devicons'
    " 对图标进行美化
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'kien/rainbow_parentheses.vim'

    Plug 'preservim/nerdtree'
    Plug 'mhinz/vim-startify'
    Plug 'easymotion/vim-easymotion'
    Plug 'lfv89/vim-interestingwords'
    Plug 'itchyny/vim-cursorword'
    Plug 'fatih/vim-go'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-speeddating'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Yggdroot/indentLine'
    Plug 'aserebryakov/vim-todo-lists'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/vim-easy-align'
    Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
    Plug 'sbdchd/neoformat'
    Plug 'dense-analysis/ale'
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'wsdjeg/vim-lua'
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'moll/vim-bbye' " buffer
call plug#end()


" ---------------------------------------
" - colorscheme
" ---------------------------------------
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
" If you would like some of the code to be bolded, like functions and language controls
let g:enable_bold_font = 0
" If you want comments to be in italic
let g:enable_italic_font = 1
" To use transparent background
let g:hybrid_transparent_background = 0
colorscheme hybrid_reverse


" ---------------------------------------
" - vim-go
" ---------------------------------------
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
" 下方显示信息
let g:go_metalinter_autosave = 0 


" ---------------------------------------
" - dart-vim-plugin
" ---------------------------------------
autocmd BufWritePre *.dart* DartFmt


" ---------------------------------------
" - vim-instant-markdown
" ---------------------------------------
let g:instant_markdown_autostart = 0


" ---------------------------------------
" - vim-bbye
" ---------------------------------------
"  Bdelete : Ctrl-o will reopen the file. (Bwipeout)
nnoremap <silent> \\ :Bdelete<CR>


" ---------------------------------------
" - ale
" ---------------------------------------
let g:ale_sign_error = '😭'
let g:ale_sign_warning = '😗'


" ---------------------------------------
" - fzf.vim
" ---------------------------------------
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <c-p> :Files<CR>


" ---------------------------------------
" tagbar
" ---------------------------------------
nmap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0    " sort by sourcefile
"let g:tagbar_show_linenumbers = 1
set updatetime=1000    " ms update


" ---------------------------------------
" - vim-easy-align
" ---------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ---------------------------------------
" - easymotion
" ---------------------------------------
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap ss <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)


" ---------------------------------------
" - neoformat
" ---------------------------------------
nnoremap <F6> :Neoformat<CR>
nnoremap ,ff :Neoformat<CR>
let g:neoformat_enabled_python = ['autopep8', 'yapf']
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END


" ---------------------------------------
" - rainbow_parentheses
" ---------------------------------------
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


" ---------------------------------------
" - Airline
" ---------------------------------------
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme='hybridline'
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


" ---------------------------------------
" - NERDTree
" ---------------------------------------
nmap <silent> ,v :NERDTreeFind<cr>
nmap <silent> ,t :NERDTreeToggle<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore = [
            \ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.pyo$', '\.svn$', '\.swp$',
            \ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.ropeproject$',
            \ '\.vscode'
            \]
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ---------------------------------------
" - Coc.nvim
" ---------------------------------------
" 绑定 ctrl-q 触发补全
inoremap <silent><expr> <C-q> coc#refresh()
let g:airline#extensions#coc#enabled = 1
" 提示标签
let airline#extensions#coc#error_symbol = '😭:'
let airline#extensions#coc#warning_symbol = '😗'
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
