" ======================================="
"  vim/neovim's configuration of wongxy. "
" ======================================="

exec 'source' '~/.config/nvim/config/general.vim'
exec 'source' '~/.config/nvim/config/keymap.vim'
exec 'source' '~/.config/nvim/config/plug.vim'
exec 'source' '~/.config/nvim/config/theme.vim'

let s:profile_path = '~/.config/nvim/profile.vim'
if filereadable(expand(s:profile_path))
    exec 'source' s:profile_path
endif
