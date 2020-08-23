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


let g:dashboard_custom_footer = ['']
let g:dashboard_custom_header = [
      \'',
      \'',
      \'',
      \'',
      \'',
      \'',
      \'',
      \]
