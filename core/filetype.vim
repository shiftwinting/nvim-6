autocmd BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc
autocmd BufNewFile,BufRead go.mod            setlocal filetype=gomod
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

autocmd FileType js,javascript,html,css,dart,yaml,json,xml,vue,rst,vim,toml
       \ setlocal shiftwidth=2 tabstop=2
