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
	["n|<leader>s"] = cr("w"),
	-- Switch window
	["n|<c-h>"] = cr("wincmd h"):silent(),
	["s|<c-j>"] = cr("wincmd j"):silent(),
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
	["i|<C-d>"] = cmd("<Del>"),
	["i|<C-h>"] = cmd("<BS>"),
	-- quickly change word
	["i|<C-w>"] = cmd("<C-o>ciw"),
	-- yank
	["n|Y"] = cmd("y$"),
	-- zero movement
	["n|0"] = cmd("getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'"):silent():expr(),
	-- quit
	["n|<space>q"] = cmd("ZZ"),
})
-- Nvim Tree
load_maps({
	["n|<leader>e"] = cr("NvimTreeToggle"):silent(),
	["n|<leader>F"] = cr("NvimTreeFindFile"):silent(),
})
-- vista
load_maps({
	["n|<leader>v"] = cr("Vista!!"),
})
-- easy align
load_maps({
	["nx|ga"] = cmd("<Plug>(EasyAlign)"):silent(),
})
-- acelerated jk (enhanced jk move)
load_maps({
	["n|j"] = cmd("<Plug>(accelerated_jk_gj)"),
	["n|k"] = cmd("<Plug>(accelerated_jk_gk)"),
})
-- hop.nvim  motion
load_maps({
	["n|<leader>w"] = cr("HopWord"),
	["n|<leader>W"] = cr("HopChar1"),
	["n|<leader>l"] = cr("HopLine"),
	["n|<leader>/"] = cr("HopPattern"),
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
	["nt|<leader>t"] = cr("ToggleTerm"):silent(),
})
----- COC ------
load_maps({
	-- Use K for show documentation in float window
	["n|K"] = cr("call CocActionAsync('doHover')"):silent(),
	-- Applying codeAction to the selected region.
	["xn|<leader>a"] = cmd("<Plug>(coc-codeaction-selected)"):silent(),
	-- " Use <c-q> for trigger completion.
	["i|<c-q>"] = cmd("coc#refresh()"):silent():expr(),
	-- " Jump definition in other window
	-- Remap keys for gotos
	["n|gd"] = cmd("<Plug>(coc-definition)"):silent(),
	["n|gy"] = cmd("<Plug>(coc-type-definition)"):silent(),
	["n|<Leader>ci"] = cmd("<Plug>(coc-implementation)"):silent(),
	["n|gr"] = cmd("<Plug>(coc-references)"):silent(),
	-- Use `[g` and `]g` to navigate diagnostics
	-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	["n|[g"] = cmd("<Plug>(coc-diagnostic-prev)"):silent(),
	["n|]g"] = cmd("<Plug>(coc-diagnostic-next)"):silent(),
	-- Symbol renaming.
	["n|<leader>rn"] = cmd("<Plug>(coc-rename)"):silent(),
	-- Format current buffer
	["nx|<leader>f"] = cmd("<Plug>(coc-format)"):silent(),
	-- Apply AutoFix to problem on the current line.
	["n|<leader>qf"] = cmd("<Plug>(coc-fix-current)"):silent(),
})
-- coc-translator --
load_maps({
	["n|tt"] = cmd("<Plug>(coc-translator-p)"):silent(),
	["v|tt"] = cmd("<Plug>(coc-translator-pv)"):silent(),
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
--- vim-dadbod-ui ---
load_maps({
	["n|<leader>od"] = cr("DBUIToggle"),
})
--- markdown-preview
load_maps({
	["n|<leader>om"] = cr("MarkdownPreviewToggle"),
})
