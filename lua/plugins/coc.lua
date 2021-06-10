vim.g.coc_snippet_next = "<C-j>"
vim.g.coc_snippet_prev = "<C-k>"
vim.g.coc_disable_transparent_cursor = 1

vim.g.coc_global_extensions = {
	"coc-clangd",
	"coc-css",
	"coc-emmet",
	"coc-eslint",
	"coc-flutter-tools",
	"coc-go",
	"coc-html",
	"coc-json",
	"coc-marketplace",
	"coc-pyright",
	"coc-prettier",
	"coc-rust-analyzer",
	"coc-sh",
	"coc-snippets",
	"coc-translator",
	"coc-tsserver",
	"coc-vetur",
	"coc-yaml",
	"coc-yank",
}

wxy.autocmd({
	-- Setup formatexpr specified filetype(s).
	"FileType typescript,json setl formatexpr=CocAction('formatSelected')",
	-- Update signature help on jump placeholder.
	"User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')",
	-- Highlight symbol under cursor on CursorHold
	"CursorHold * silent call CocActionAsync('highlight')",
	-- Automaticlly Organize Imports when save
	"BufWritePre *.go call CocAction('runCommand', 'editor.action.organizeImport')",
})

--use tab to navigate autocomplete
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Use (s-)tab to move back
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t("<C-n>")
	elseif check_back_space() then
		return t("<Tab>")
	else
		return vim.fn["coc#refresh"]()
	end
end

_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t("<C-p>")
	else
		return t("<S-Tab>")
	end
end

local keybind = wxy.keybind
local cmd = keybind.cmd

keybind.load_maps({
	-- (s-)tab
	["is|<Tab>"] = cmd([[v:lua.tab_complete()]]):silent():expr():noremap(),
	["is|<S-Tab>"] = cmd([[v:lua.s_tab_complete()]]):silent():expr():noremap(),
	-- C-f/b
	["nv|<C-f>"] = cmd([[coc#float#has_scroll() ? coc#float#scroll(1) : ":lua require('neoscroll').scroll( vim.api.nvim_win_get_height(0), true, 550)<CR>"]]):silent():expr():noremap(),
	["nv|<C-b>"] = cmd([[coc#float#has_scroll() ? coc#float#scroll(0) : ":lua require('neoscroll').scroll( -vim.api.nvim_win_get_height(0), true, 550)<CR>"]]):silent():expr():noremap(),
	["i|<C-f>"] = cmd([[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]]):silent():expr():noremap(),
	["i|<C-b>"] = cmd([[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]]):silent():expr():noremap(),
	-- Use <cr> to confirm completion
	["i|<cr>"] = cmd([[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]):silent():expr():noremap(),
})
-- inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
