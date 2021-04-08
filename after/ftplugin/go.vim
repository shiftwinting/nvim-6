nnoremap <silent> <leader>r :AsyncRun -mode=term go run '$(VIM_FILEPATH)'<CR>
nnoremap <silent> <leader>R :AsyncRun -mode=term go run .<CR>

setlocal iskeyword+="
setlocal noexpandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
