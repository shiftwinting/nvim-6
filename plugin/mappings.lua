-- This module should define mappings only those have no other dependencies
-- or are used for lazy loading
local bind = wxy.keybind
local cmd = bind.cmd
local cu = bind.cu
local cr = bind.cr
local load_maps = bind.load_maps

vim.g.mapleader = ','

-- Basic --
load_maps {
  ['n|;'] = cmd ':',
  ['i|jj'] = cmd '<esc>`^',
  ['i|jk'] = cmd '<esc>`^',
  -- Save buffer
  ['n|<leader>s'] = cr 'w!',
  -- Switch window
  ['n|<c-h>'] = cr('wincmd h'):silent(),
  ['n|<c-j>'] = cr('wincmd j'):silent(),
  ['n|<c-k>'] = cr('wincmd k'):silent(),
  ['n|<c-l>'] = cr('wincmd l'):silent(),
  -- delete inline words
  ['n|dl'] = cmd 'D',
  ['n|dh'] = cmd 'd0x',
  -- Insert new line
  ['i|<C-l>'] = cmd '<C-o>A',
  ['i|<C-j>'] = cmd '<C-o>o',
  ['i|<C-k>'] = cmd '<C-o>O',
  -- Indent
  ['x|<'] = cmd '<gv',
  ['x|>'] = cmd '>gv',
  -- Backspace
  ['ic|<C-d>'] = cmd '<Del>',
  ['ic|<C-h>'] = cmd '<BS>',
  -- quickly change word
  ['i|<C-w>'] = cmd '<C-o>ciw',
  -- yank
  ['n|Y'] = cmd 'y$',
  -- movement
  ['n|0'] = cmd("getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'"):silent():expr(),
  ['i|<A-h>'] = cmd '<Left>',
  ['i|<A-j>'] = cmd '<Down>',
  ['i|<A-l>'] = cmd '<Right>',
  ['i|<A-k>'] = cmd '<Up>',
  ['ic|<C-a>'] = cmd '<Home>',
  ['ic|<C-e>'] = cmd '<End>',
  -- quit
  ['n|<space>q'] = cmd 'ZZ',
  -- confirm in cmdline
  ['c|<C-o>'] = cmd '<CR>',
  -- quickly add empty lines
  ['n|[<space>'] = cmd ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[",
  ['n|]<space>'] = cu 'put =repeat(nr2char(10), v:count1)',

  -- Nvim Tree
  ['n|<leader>e'] = cr('NvimTreeToggle'):silent(),
  ['n|<leader>F'] = cr('NvimTreeFindFile'):silent(),

  -- vista
  ['n|<leader>v'] = cr('Vista!!'):silent(),

  -- acelerated jk (enhanced jk move)
  ['n|j'] = cmd '<Plug>(accelerated_jk_gj)',
  ['n|k'] = cmd '<Plug>(accelerated_jk_gk)',

  -- hop.nvim  motion
  ['n|<leader>w'] = cr('HopWord'):silent(),
  ['n|<leader>W'] = cr('HopChar1'):silent(),
  ['n|<leader>l'] = cr('HopLine'):silent(),
  ['n|<leader>/'] = cr('HopPattern'):silent(),

  -- vim-niceblock
  ['x|I'] = cmd '<Plug>(niceblock-I)',
  ['x|A'] = cmd '<Plug>(niceblock-A)',

  -- telescope
  ['n|<space>tc'] = cr('Telescope colorscheme'):silent(),
  ['n|<space>ff'] = cr('Telescope find_files'):silent(),
  ['n|<space>fh'] = cr('Telescope oldfiles'):silent(),
  ['n|<space>fb'] = cr('Telescope buffers'):silent(),
  ['n|<space>fw'] = cr('Telescope live_grep'):silent(),
  ['n|<space>fm'] = cr('Telescope marks'):silent(),

  -- Nvim Bufferline
  ['n|<leader>b'] = cr('BufferLinePick'):silent(),
  ['n|]b'] = cr('BufferLineCycleNext'):silent(),
  ['n|[b'] = cr('BufferLineCyclePrev'):silent(),

  -- Nvim toggleterm --
  ['n|<leader>ot'] = cr('ToggleTerm'):silent(),
  ['t|<leader>ot'] = cmd('<C-\\><C-n><CMD>ToggleTerm<CR>'):silent(),
  ['n|<leader>og'] = cr('LazyGit'):silent(),
  ['t|<leader>og'] = cmd('<C-\\><C-n><CMD>LazyGit<CR>'):silent(),

  -- resize widnow by talek/obvious-resize --
  ['n|<C-Up>'] = cu('ObviousResizeUp'):silent(),
  ['n|<C-Down>'] = cu('ObviousResizeDown'):silent(),
  ['n|<C-Left>'] = cu('ObviousResizeLeft'):silent(),
  ['n|<C-Right>'] = cu('ObviousResizeRight'):silent(),

  --- neogit ---
  ['n|<space>gs'] = cr('Neogit kind=split'):silent(),
  ['n|<space>gc'] = cr('Neogit commit'):silent(),
  ['n|<space>gl'] = cr('Neogit pull'):silent(),
  ['n|<space>gp'] = cr('Neogit push'):silent(),

  --- markdown-preview
  ['n|<leader>om'] = cr('MarkdownPreviewToggle'):silent(),
}
