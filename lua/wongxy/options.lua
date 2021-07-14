local opt = vim.opt
local fn = vim.fn

opt.shortmess = {
  t = true,
  A = true,
  o = true,
  O = true,
  T = true,
  f = true,
  F = true,
  s = true,
  c = true,
  W = true,
}

-- timings
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100

-- splitting
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.eadirection = 'hor'
opt.switchbuf = { 'useopen', 'uselast' }
opt.fillchars = {
  vert = '▕',
  fold = ' ',
  eob = ' ',
  diff = '╱',
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}

-- diff
opt.diffopt:append {
  'vertical',
  'iwhite',
  'hiddenoff',
  'foldcolumn:0',
  'context:4',
  'algorithm:histogram',
  'indent-heuristic',
}

-- format options
opt.formatoptions = {
  ['1'] = true,
  ['2'] = true,
  q = true,
  c = true,
  r = true,
  n = true,
  t = false,
  j = true,
  l = true,
  v = true,
}

opt.foldlevelstart = 3

opt.wildmode = 'full'
opt.wildignorecase = true
opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  '*.webm',
  '*.eot',
  '*.otf',
  '*.ttf',
  '*.woff',
  '*.doc',
  '*.pdf',
  '*.zip',
  '*.tar.gz',
  '*.tar.bz2',
  '*.rar',
  '*.tar.xz',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '.DS_Store',
  '._*',
  'tags.lock',
}
opt.wildoptions = 'pum'

-- display
opt.colorcolumn = '80'
opt.showbreak = '↳ '
opt.signcolumn = 'yes:2'
opt.synmaxcol = 1024
opt.linebreak = true
opt.breakindentopt = 'sbr'
opt.conceallevel = 2

opt.list = true
opt.listchars = {
  eol = ' ',
  tab = '»·',
  extends = '›',
  precedes = '‹',
  trail = '·', --
}

-- Indentation
opt.wrap = false
opt.textwidth = 80
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

opt.termguicolors = true
opt.mouse = 'a'
opt.fileformats = { 'unix', 'mac', 'dos' }
opt.virtualedit = 'block'
opt.viewoptions = { 'cursor', 'folds' }
opt.sessionoptions = {
  'globals',
  'buffers',
  'curdir',
  'help',
  'winpos',
  -- "tabpages",
}
opt.clipboard = { 'unnamedplus' }

opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.wrapscan = true
opt.inccommand = 'nosplit'

opt.grepformat = '%f:%l:%c:%m'
if fn.executable 'rg' > 0 then
  opt.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
elseif fn.executable 'ag' > 0 then
  opt.grepprg = [[ag --nogroup --nocolor --vimgrep]]
end

opt.completeopt = { 'menuone', 'noselect' }
opt.showmode = false
opt.scrolloff = 4
opt.sidescrolloff = 5
opt.ruler = false
opt.pumheight = 15
opt.cmdheight = 2
opt.pumblend = 15
opt.winblend = 15

opt.guifont = 'OperatorMono Nerd Font:h15'
