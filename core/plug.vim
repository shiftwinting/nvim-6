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
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'hardcoreplayers/spaceline.vim'

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
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye', { 'on': 'Bdelete' }
Plug 'voldikss/vim-floaterm'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'pechorin/any-jump.vim', { 'on': 'AnyJump' }
Plug 'editorconfig/editorconfig-vim'
Plug 'farmergreg/vim-lastplace'
Plug 'rhysd/accelerated-jk'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}
Plug 'wsdjeg/vim-lua', { 'for': 'lua' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
call plug#end()

for s:plugin_name in g:plugs_order
  if isdirectory(g:plugs[s:plugin_name].dir)
		call utils#check_source(expand('~/.config/nvim/plugins/' . s:plugin_name . '.vim'))
  endif
endfor
