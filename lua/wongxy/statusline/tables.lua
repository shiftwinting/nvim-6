local colors = {
  bg = 'NONE', --"#202328",
  fg = '#f1f2f6',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local mode_colors = {
  n = colors.red,
  i = colors.green,
  v = colors.blue,
  [''] = colors.blue,
  V = colors.blue,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [''] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.red,
}
local mode_symbols = {
  n = ' ',
  i = ' ',
  v = ' ',
  [''] = ' ',
  V = ' ',
  c = '↪ ',
  no = ' ',
  s = ' ',
  S = ' ',
  [''] = ' ',
  ic = ' ',
  R = ' ',
  Rv = ' ',
  cv = '↪ ',
  ce = '↪ ',
  r = ' ',
  rm = ' ',
  ['r?'] = ' ',
  ['!'] = 'SE',
  t = 'ﭨ ',
}

local mode_names = setmetatable({
  ['n'] = 'NORMAL',
  ['no'] = 'N·OPERATOR PENDING ',
  ['v'] = 'VISUAL',
  ['V'] = 'V·LINE',
  [''] = 'V·BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S·LINE',
  ['^S'] = 'S·BLOCK',
  ['i'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'V·REPLACE',
  ['Rx'] = 'C·REPLACE',
  ['Rc'] = 'C·REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}, {
  __index = function(t, k)
    t[k] = 'UNKOWN'
    return t[k]
  end,
})

local exceptions = {
  buftypes = {
    terminal = ' ',
    quickfix = '',
  },
  filetypes = {
    ['himalaya-msg-list'] = '',
    mail = '',
    dbui = '',
    vista = 'פּ',
    tsplayground = '侮',
    fugitive = '',
    fugitiveblame = '',
    gitcommit = '',
    startify = '',
    defx = '⌨',
    ctrlsf = '🔍',
    Trouble = '',
    NeogitStatus = '',
    ['vim-plug'] = '⚉',
    vimwiki = 'ﴬ',
    help = '',
    undotree = 'פּ',
    ['coc-explorer'] = '',
    NvimTree = 'פּ',
    toggleterm = ' ',
    calendar = '',
    octo = '',
    ['dap-repl'] = '',
    packer = '',
  },
}

return {
  colors = colors,
  conditions = conditions,
  mode_colors = mode_colors,
  mode_symbols = mode_symbols,
  mode_names = mode_names,
  exceptions = exceptions,
}
