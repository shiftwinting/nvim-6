local fn = vim.fn

local toggle_trailing = function(mode)
  if
    vim.bo.filetype == ''
    or vim.bo.buftype ~= ''
    or not vim.bo.modifiable
    or fn.win_gettype() == 'popup'
  then
    vim.wo.list = false
    return
  end
  if not vim.wo.list then
    vim.wo.list = true
  end
  local pattern = mode == 'i' and [[\s\+\%#\@<!$]] or [[\s\+$]]
  if vim.w.whitespace_match_number then
    fn.matchdelete(vim.w.whitespace_match_number)
    fn.matchadd('ExtraWhitespace', pattern, 10, vim.w.whitespace_match_number)
  else
    vim.w.whitespace_match_number = fn.matchadd('ExtraWhitespace', pattern)
  end
end

vim.cmd [[hi! ExtraWhitespace guifg=red]]

wxy.augroup('WhitespaceMatch', {
  'ColorScheme * hi! ExtraWhitespace guifg=red',
  {
    { 'BufEnter', 'FileType', 'InsertLeave' },
    function()
      toggle_trailing 'n'
    end,
    '*',
  },
  {
    'InsertEnter',
    function()
      toggle_trailing 'i'
    end,
    '*',
  },
})
