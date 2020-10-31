let s:enable_whichkey = dein#tap('vim-which-key')

if s:enable_whichkey
  function! InitWhickey()
    let s:leader_key=substitute(get(g:,"mapleader","\\"), ' ', ',', '')
    let s:localleader_key= get(g:,'maplocalleader',';')
    execute 'nnoremap <silent> <Leader> :<c-u>WhichKey "'.s:leader_key.'"<CR>'
    execute 'vnoremap <silent> <Leader> :<c-u>WhichKeyVisual "'.s:leader_key.'"<CR>'
    execute 'nnoremap <silent> <LocalLeader> :<c-u>WhichKey "' .s:localleader_key.'"<CR>'
  endfunction
  call InitWhickey()
  let g:which_key_map.c = { 'name': '+code' }
  let g:which_key_map.f = { 'name': '+find'}
  let g:which_key_map.o = { 'name': '+open' }
  let g:which_key_map.t = { 'name': '+toggle'}
  let g:which_key_map.g = { 'name': '+versioncontrol'}
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('dein.vim')
  nnoremap <silent> <Leader>pu  :call dein#update()<CR>
  nnoremap <silent> <Leader>pr  :call dein#recache_runtimepath()<CR>
  nnoremap <silent> <Leader>pl  :echo dein#get_updates_log()<CR>
  if s:enable_whichkey
    let g:which_key_map.p = { 'name': '+plugin'}
    let g:which_key_map.p.u = 'update all plugins'
    let g:which_key_map.p.r = 'reache runtime path'
    let g:which_key_map.p.l = 'plugins update log'
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-clap')
  nnoremap <silent> <space>tc :<C-u>Clap colors<CR>
  nnoremap <silent> <space>bb :<C-u>Clap buffers<CR>
  nnoremap <silent> <space>fa :<C-u>Clap grep2<CR>
  nnoremap <silent> <space>fb :<C-u>Clap marks<CR>
 
  nnoremap <silent> <C-x><C-f> :<C-u>Clap filer<CR>
  nnoremap <silent> <space>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
  nnoremap <silent> <space>fg :<C-u>Clap gfiles<CR>
  nnoremap <silent> <space>fw :<C-u>Clap grep ++query=<cword><cr>
  nnoremap <silent> <space>fh :<C-u>Clap history<CR>
  nnoremap <silent> <space>fW :<C-u>Clap windows<CR>
  nnoremap <silent> <space>fl :<C-u>Clap loclist<CR>
  nnoremap <silent> <space>fu :<C-u>Clap git_diff_files<CR>
  nnoremap <silent> <space>fv :<C-u>Clap grep ++query=@visual<CR>
  nnoremap <silent> <space>oc :<C-u>Clap personalconf<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('coc-clap')
  " Show all diagnostics
  nnoremap <silent> <space>a  :Clap coc_diagnostics<CR>
  " Manage extensions
  nnoremap <silent> <space>e  :Clap coc_extensions<CR>
  " Show commands
  nnoremap <silent> <space>c  :Clap coc_commands<CR>
  " Search workspace symbols
  nnoremap <silent> <space>s  :Clap coc_symbols<CR>
  nnoremap <silent> <space>S  :Clap coc_services<CR>
  nnoremap <silent> <space>o  :Clap coc_outline<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('nvim-bufferline.lua')
  nnoremap <silent> <leader>b :BufferLinePick<CR>
  nnoremap <silent> ]b :BufferLineCycleNext<CR>
  nnoremap <silent> [b :BufferLineCyclePrev<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('dashboard-nvim')
  nnoremap <silent> <Leader>os  :<C-u>Dashboard<CR>
  if s:enable_whichkey
    let g:which_key_map.o.s = 'open dashboard'
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('coc.nvim')
  " Use K for show documentation in float window
  nnoremap <silent> K :call CocActionAsync('doHover')<CR>
  " Use <c-q> for trigger completion.
  inoremap <silent><expr> <c-q> coc#refresh()
  " Jump definition in other window
  function! s:definition_other_window() abort
    if winnr('$') >= 4 || winwidth(0) < 120
      exec "normal \<Plug>(coc-definition)"
    else
      exec 'vsplit'
      exec "normal \<Plug>(coc-definition)"
    endif
  endfunction
  " Remap keys for gotos
  nmap <silent> gd :<C-u>call <sid>definition_other_window()<CR>
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> <Leader>ci <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)
  " Format current buffer
  xmap <silent> <leader>f  <Plug>(coc-format)
  nmap <silent> <leader>f  <Plug>(coc-format)
  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  " xmap <leader>a  <Plug>(coc-codeaction-selected)
  " nmap <leader>a  <Plug>(coc-codeaction-selected)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)
  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)
  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')
  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
  """"""""""""""""coc-translator""""""""""""""""""""""""
  nmap tt <Plug>(coc-translator-p)
  vmap tt <Plug>(coc-translator-pv)
  """"""""""""""""coc-actions""""""""""""""""""""""""
  " Remap for do codeAction of selected region
  function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
  endfunction
  xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
  nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-floaterm')
	nnoremap <silent> <Leader>ot :<C-u>FloatermToggle<CR>
	tnoremap <silent> <Leader>ot <C-\><C-n>FloatermToggle<CR>
	nnoremap <silent> <Leader>gz :<C-u>FloatermNew height=0.7 width=0.8 lazygit<CR>
	if s:enable_whichkey
		let g:which_key_map.o.t = 'open terminal'
		let g:which_key_map.g.z = 'lazygit'
	endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('go.vim')
  function! InitGoKeyMap() abort
    nnoremap <silent> <LocalLeader>ga :GoAddTags<CR>
    nnoremap <silent> <LocalLeader>gr :GoRemoveTags<CR>
    if s:enable_whichkey
      let g:which_key_localmap.g = { 'name': '+GoToolKit'}
      let g:which_key_localmap.g.a = 'Add tags'
      let g:which_key_localmap.g.r = 'Remove tags'
    endif
  endfunction
  autocmd FileType go call InitGoKeyMap()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-fugitive')
	nnoremap <silent> <Leader>ga :Git add %:p<CR>
	nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
	nnoremap <silent> <Leader>gc :Git commit<CR>
	nnoremap <silent> <Leader>gb :Git blame<CR>
	nnoremap <silent> <Leader>gf :Gfetch<CR>
	nnoremap <silent> <Leader>gs :Git<CR>
	nnoremap <silent> <Leader>gp :Gpush<CR>
	if s:enable_whichkey
		let g:which_key_map.g.a = 'git add'
		let g:which_key_map.g.d = 'git diff split'
		let g:which_key_map.g.b = 'git blame'
		let g:which_key_map.g.f = 'git fetch'
		let g:which_key_map.g.c = 'git commit'
		let g:which_key_map.g.s = 'git status'
		let g:which_key_map.g.p = 'git push'
	endif
endif

if dein#tap('vim-mundo')
	nnoremap <silent> <Leader>m :MundoToggle<CR>
	if s:enable_whichkey
		let g:which_key_map.m = 'MundoToggle'
	endif
endif

if dein#tap('caw.vim')
	function! InitCaw() abort
		if ! &l:modifiable
			silent! nunmap <buffer> gc
			silent! xunmap <buffer> gc
			silent! nunmap <buffer> gcc
			silent! xunmap <buffer> gcc
		else
			nmap <buffer> gc <Plug>(caw:prefix)
			xmap <buffer> gc <Plug>(caw:prefix)
			nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
			xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
		endif
	endfunction
	autocmd FileType * call InitCaw()
	call InitCaw()
endif

if dein#tap('vim-smoothie')
	nnoremap <silent> <C-f> :<C-U>call smoothie#forwards()<CR>
	nnoremap <silent> <C-b> :<C-U>call smoothie#backwards()<CR>
	nnoremap <silent> <C-d> :<C-U>call smoothie#downwards()<CR>
	nnoremap <silent> <C-u> :<C-U>call smoothie#upwards()<CR>
endif

if dein#tap('defx.nvim')
	nnoremap <silent> <Leader>e
		\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
	nnoremap <silent> <Leader>F
		\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
	if s:enable_whichkey
		let g:which_key_map.e = 'Open defx'
		let g:which_key_map.F = 'Open current file on defx'
	endif
endif

if dein#tap('nvim-tree.lua')
  nnoremap <silent> <leader>e :LuaTreeToggle<CR>
  nnoremap <silent> <leader>F :LuaTreeFindFile<CR>
endif

if dein#tap('vista.vim')
	nnoremap <silent> <Leader>i :<C-u>Vista!!<CR>
	if s:enable_whichkey
		let g:which_key_map.i = 'Vista'
	endif
endif

if dein#tap('vim-easymotion')
	nmap ss <Plug>(easymotion-overwin-f2)
	map  <Leader>l <Plug>(easymotion-bd-jk)
	nmap <Leader>l <Plug>(easymotion-overwin-line)
	map  <Leader>w <Plug>(easymotion-bd-w)
	nmap <Leader>w <Plug>(easymotion-overwin-w)
endif

if dein#tap('any-jump.vim')
	nnoremap <silent> <Leader>j :AnyJump<CR>
endif

if dein#tap('vim-easy-align')
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

if dein#tap('accelerated-jk')
	nmap <silent>j <Plug>(accelerated_jk_gj)
	nmap <silent>k <Plug>(accelerated_jk_gk)
endif

if dein#tap('goyo.vim')
  nnoremap <silent> <Leader>G :Goyo<CR>
  if s:enable_whichkey
    let g:which_key_map.G = 'Goyo'
  endif
endif


" base mappings
nnoremap s <nop>

nnoremap <space><space> zz
nnoremap <space>q ZZ

noremap Y y$
nnoremap <silent> <leader>s :w!<cr>
nnoremap <silent> <leader>h :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" clipboard
noremap <silent> <leader>p "+p

nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" back to normal
inoremap jj <Esc>`^

" inoremap <C-i> <C-o>I
inoremap <C-l> <C-o>A
inoremap <C-j> <C-o>o
inoremap <C-k> <C-o>O

inoremap <C-w> <C-o>ciw

inoremap <C-d> <Del>
inoremap <C-h> <BS>

xnoremap <  <gv
xnoremap >  >gv

nnoremap dl D
nnoremap dh d0x
