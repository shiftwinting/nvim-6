wxy.command {
  'BufOnly',
  function()
    local cur_buf = vim.api.nvim_get_current_buf()
    for _, n in ipairs(vim.api.nvim_list_bufs()) do
      if
        n ~= cur_buf
        and vim.api.nvim_buf_is_loaded(n)
        and not vim.api.nvim_buf_get_option(n, 'modified')
      then
        vim.api.nvim_buf_delete(n, {})
      end
    end
  end,
}

wxy.command {
  'BufKill',
  function()
    vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {})
  end,
}
