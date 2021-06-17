" Delete all the buffers except the current/modified buffer.

fu! s:bufonly()
  let cur_buf = nvim_get_current_buf()
  for n in nvim_list_bufs()
    if n != cur_buf && !nvim_buf_get_option(n, 'modified')
      call nvim_buf_delete(n, {})
    endif
  endfor
endfu

command! -nargs=0 BufOnly call s:bufonly()


" Kill current buffer
command! -nargs=0 BufKill call nvim_buf_delete(nvim_get_current_buf(),{})

"vim: set ts=2 sw=2 tw=80 noet :
