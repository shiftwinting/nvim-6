local global_options = {
  termguicolors = true,
  mouse = "a",
  errorbells = true,
  visualbell = true,
  hidden = true,
  fileformats = "unix,mac,dos",
  magic = true,
  virtualedit = "block",
  encoding = "utf-8",
  viewoptions = "folds,cursor,curdir,slash,unix",
  sessionoptions = "curdir,help,tabpages,winsize",
  clipboard = "unnamedplus",
  wildignorecase = true,
  wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
  backup = false,
  writebackup = false,
  undofile = true,
  swapfile = false,
  directory = CACHE_PATH .. "swag/",
  undodir = CACHE_PATH .. "undo/",
  backupdir = CACHE_PATH .. "backup/",
  viewdir = CACHE_PATH .. "view/",
  spellfile = CACHE_PATH .. "spell/en.uft-8.add",
  history = 2000,
  shada = "!,'300,<50,@100,s10,h",
  backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
  smarttab = true,
  shiftround = true,
  timeout = true,
  ttimeout = true,
  timeoutlen = 500,
  ttimeoutlen = 10,
  updatetime = 100,
  redrawtime = 1500,
  ignorecase = true,
  smartcase = true,
  infercase = true,
  incsearch = true,
  wrapscan = true,
  complete = ".,w,b,k",
  inccommand = "nosplit",
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --hidden --vimgrep --smart-case --",
  breakat = [[\ \	;:,!?]],
  startofline = false,
  whichwrap = "h,l,<,>,[,],~",
  splitbelow = true,
  splitright = true,
  switchbuf = "useopen",
  backspace = "indent,eol,start",
  diffopt = "filler,iwhite,internal,algorithm:patience",
  completeopt = "menuone,noselect",
  jumpoptions = "stack",
  showmode = false,
  shortmess = "aoOTIcF",
  scrolloff = 2,
  sidescrolloff = 5,
  foldlevelstart = 99,
  ruler = false,
  list = true,
  showtabline = 2,
  winwidth = 30,
  winminwidth = 10,
  pumheight = 15,
  helpheight = 12,
  previewheight = 12,
  showcmd = false,
  cmdheight = 2,
  cmdwinheight = 5,
  equalalways = false,
  laststatus = 2,
  display = "lastline",
  showbreak = "↳  ",
  listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
  pumblend = 20,
  winblend = 20,
  guifont = "OperatorMono Nerd Font:h15",
}
local buffer_options = {
  synmaxcol = 2500,
  formatoptions = "1jcroql",
  textwidth = 80,
  expandtab = true,
  autoindent = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = -1,
}
local window_options = {
  number = true,
  relativenumber = true,
  colorcolumn = "80",
  signcolumn = "yes",
  wrap = false,
  linebreak = true,
  breakindentopt = "shift:2,min:20",
  foldenable = true,
  conceallevel = 2,
  concealcursor = "niv",
}

local opt = function(name, value, scopes)
  scopes = scopes or { vim.o }
  for _, scope in ipairs(scopes) do
    scope[name] = value
  end
end

local load_opt = function(options, scopes)
  for name, value in pairs(options) do
    opt(name, value, scopes)
  end
end

load_opt(global_options)
load_opt(buffer_options, { vim.o, vim.bo })
load_opt(window_options, { vim.o, vim.wo })
