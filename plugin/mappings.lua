-- This module should define mappings only those have no other dependencies
-- or are used for lazy loading
local bind = wxy.keybind
local cmd = bind.cmd
local cu = bind.cu
local cr = bind.cr
local load_maps = bind.load_maps

vim.g.mapleader = ","

-- Basic --
load_maps({
  ["n|s"] = cmd(""),
  ["n|;"] = cmd(":"),
  ["i|jj"] = cmd("<esc>`^"),
  ["i|jk"] = cmd("<esc>`^"),
  -- Save buffer
  ["n|<leader>s"] = cr("w!"),
  -- Switch window
  ["n|<c-h>"] = cr("wincmd h"):silent(),
  ["n|<c-j>"] = cr("wincmd j"):silent(),
  ["n|<c-k>"] = cr("wincmd k"):silent(),
  ["n|<c-l>"] = cr("wincmd l"):silent(),
  -- delete inline words
  ["n|dl"] = cmd("D"),
  ["n|dh"] = cmd("d0x"),
  -- Insert new line
  ["i|<C-l>"] = cmd("<C-o>A"),
  ["i|<C-j>"] = cmd("<C-o>o"),
  ["i|<C-k>"] = cmd("<C-o>O"),
  -- Indent
  ["x|<"] = cmd("<gv"),
  ["x|>"] = cmd(">gv"),
  -- Backspace
  ["ic|<C-d>"] = cmd("<Del>"),
  ["ic|<C-h>"] = cmd("<BS>"),
  -- quickly change word
  ["i|<C-w>"] = cmd("<C-o>ciw"),
  -- yank
  ["n|Y"] = cmd("y$"),
  -- movement
  ["n|j"] = cmd("gj"),
  ["n|k"] = cmd("gk"),
  ["n|0"] = cmd("getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'"):silent():expr(),
  ["i|<A-h>"] = cmd("<Left>"),
  ["i|<A-j>"] = cmd("<Down>"),
  ["i|<A-l>"] = cmd("<Right>"),
  ["i|<A-k>"] = cmd("<Up>"),
  ["ic|<C-a>"] = cmd("<Home>"),
  ["ic|<C-e>"] = cmd("<End>"),
  -- quit
  ["n|<space>q"] = cmd("ZZ"),
  ["c|<C-o>"] = cmd("<CR>"),
})
-- Nvim Tree
load_maps({
  ["n|<leader>e"] = cr("NvimTreeToggle"):silent(),
  ["n|<leader>F"] = cr("NvimTreeFindFile"):silent(),
})
-- vista
load_maps({
  ["n|<leader>v"] = cr("Vista!!"):silent(),
})
-- acelerated jk (enhanced jk move)
load_maps({
  ["n|j"] = cmd("<Plug>(accelerated_jk_gj)"),
  ["n|k"] = cmd("<Plug>(accelerated_jk_gk)"),
})
-- hop.nvim  motion
load_maps({
  ["n|<leader>w"] = cr("HopWord"):silent(),
  ["n|<leader>W"] = cr("HopChar1"):silent(),
  ["n|<leader>l"] = cr("HopLine"):silent(),
  ["n|<leader>/"] = cr("HopPattern"):silent(),
})
-- vim-niceblock
load_maps({
  ["x|I"] = cmd("<Plug>(niceblock-I)"),
  ["x|A"] = cmd("<Plug>(niceblock-A)"),
})
-- telescope
load_maps({
  ["n|<space>tc"] = cr("Telescope colorscheme"):silent(),
  ["n|<space>ff"] = cr("Telescope find_files"):silent(),
  ["n|<space>fh"] = cr("Telescope oldfiles"):silent(),
  ["n|<space>fb"] = cr("Telescope buffers"):silent(),
  ["n|<space>fw"] = cr("Telescope live_grep"):silent(),
  ["n|<space>fm"] = cr("Telescope marks"):silent(),
})
-- telescope-coc
load_maps({
  ["n|<space>a"] = cr("Telescope coc diagnostics"):silent(),
  ["n|<space>A"] = cr("Telescope coc workspace_diagnostics"):silent(),
  ["n|<space>s"] = cr("Telescope coc document_symbols"):silent(),
  ["n|<space>S"] = cr("Telescope coc workspace_symbols"):silent(),
  ["n|<space>c"] = cr("Telescope coc commands"):silent(),
  ["n|<space>d"] = cr("Telescope coc definitions"):silent(),
})
-- Nvim Bufferline
load_maps({
  ["n|<leader>b"] = cr("BufferLinePick"):silent(),
  ["n|]b"] = cr("BufferLineCycleNext"):silent(),
  ["n|[b"] = cr("BufferLineCyclePrev"):silent(),
})
-- Nvim toggleterm --
load_maps({
  ["n|<leader>ot"] = cr("ToggleTerm"):silent(),
  ["t|<leader>ot"] = cmd("<C-\\><C-n><CMD>ToggleTerm<CR>"):silent(),
  ["n|<leader>og"] = cr("LazyGit"):silent(),
  ["t|<leader>og"] = cmd("<C-\\><C-n><CMD>LazyGit<CR>"):silent(),
})
-- resize widnow by talek/obvious-resize --
load_maps({
  ["n|<C-Up>"] = cu("ObviousResizeUp"):silent(),
  ["n|<C-Down>"] = cu("ObviousResizeDown"):silent(),
  ["n|<C-Left>"] = cu("ObviousResizeLeft"):silent(),
  ["n|<C-Right>"] = cu("ObviousResizeRight"):silent(),
})
--- neogit ---
load_maps({
  ["n|<space>gs"] = cr("Neogit kind=split"):silent(),
  ["n|<space>gc"] = cr("Neogit commit"):silent(),
  ["n|<space>gl"] = cr("Neogit pull"):silent(),
  ["n|<space>gp"] = cr("Neogit push"):silent(),
})
--- markdown-preview
load_maps({
  ["n|<leader>om"] = cr("MarkdownPreviewToggle"):silent(),
})
