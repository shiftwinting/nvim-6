" >>> neoclide/coc.nvim
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '✗'
let g:coc_status_warning_sign = '≈'
let g:coc_disable_transparent_cursor = 1

let g:coc_global_extensions = [
            \'coc-calc',
            \'coc-clangd',
            \'coc-css',
            \'coc-emmet',
            \'coc-eslint',
            \'coc-flutter',
            \'coc-git',
            \'coc-highlight',
            \'coc-html',
            \'coc-json',
            \'coc-lua',
            \'coc-marketplace',
            \'coc-prettier',
            \'coc-python', 
            \'coc-rust-analyzer',
            \'coc-snippets',
            \'coc-translator',
            \'coc-tsserver',
            \'coc-vetur',
            \'coc-yaml',
            \'coc-yank'
            \]

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
