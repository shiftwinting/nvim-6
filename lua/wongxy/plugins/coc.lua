vim.g.coc_snippet_next = '<C-j>'
vim.g.coc_snippet_prev = '<C-k>'
vim.g.coc_disable_transparent_cursor = 1

vim.g.coc_global_extensions = {
  'coc-clangd',
  'coc-css',
  'coc-emmet',
  'coc-eslint',
  'coc-flutter-tools',
  'coc-go',
  'coc-html',
  'coc-json',
  'coc-marketplace',
  'coc-pyright',
  'coc-prettier',
  'coc-rust-analyzer',
  'coc-sh',
  'coc-snippets',
  'coc-translator',
  'coc-tsserver',
  'coc-vetur',
  'coc-yaml',
  'coc-sumneko-lua',
  'coc-stylua',
}

wxy.autocmd {
  -- Setup formatexpr specified filetype(s).
  "FileType typescript,json setl formatexpr=CocAction('formatSelected')",
  -- Update signature help on jump placeholder.
  "User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')",
  -- Highlight symbol under cursor on CursorHold
  "CursorHold * silent call CocActionAsync('highlight')",
  -- Automaticlly Organize Imports when save
  "BufWritePre *.go call CocAction('runCommand', 'editor.action.organizeImport')",
}

--use tab to navigate autocomplete
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

-- Use (s-)tab to move back
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['coc#refresh']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

local keybind = wxy.keybind
local cmd = keybind.cmd
local cr = keybind.cr

keybind.load_maps {
  -- (s-)tab
  ['is|<Tab>'] = cmd([[v:lua.tab_complete()]]):silent():expr():noremap(),
  ['is|<S-Tab>'] = cmd([[v:lua.s_tab_complete()]]):silent():expr():noremap(),
  -- C-f/b
  ['nv|<C-f>'] = cmd(
    [[coc#float#has_scroll() ? coc#float#scroll(1) : ":lua require('neoscroll').scroll( vim.api.nvim_win_get_height(0), true, 550)<CR>"]]
  )
    :silent()
    :expr()
    :noremap(),
  ['nv|<C-b>'] = cmd(
    [[coc#float#has_scroll() ? coc#float#scroll(0) : ":lua require('neoscroll').scroll( -vim.api.nvim_win_get_height(0), true, 550)<CR>"]]
  )
    :silent()
    :expr()
    :noremap(),
  ['i|<C-f>'] = cmd([[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]])
    :silent()
    :expr()
    :noremap(),
  ['i|<C-b>'] = cmd([[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]])
    :silent()
    :expr()
    :noremap(),
  -- Use <cr> to confirm completion
  ['i|<cr>'] = cmd(
    [[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]
  )
    :silent()
    :expr()
    :noremap(),
  -- Use K for show documentation in float window
  ['n|K'] = cr("call CocActionAsync('doHover')"):silent(),
  -- Applying codeAction to the selected region.
  ['xn|<leader>a'] = cmd('<Plug>(coc-codeaction-selected)'):silent(),
  -- " Use <c-q> for trigger completion.
  ['i|<c-q>'] = cmd('coc#refresh()'):silent():expr(),
  -- " Jump definition in other window
  -- Remap keys for gotos
  ['n|gd'] = cmd('<Plug>(coc-definition)'):silent(),
  ['n|gy'] = cmd('<Plug>(coc-type-definition)'):silent(),
  ['n|gi'] = cmd('<Plug>(coc-implementation)'):silent(),
  ['n|gr'] = cmd('<Plug>(coc-references)'):silent(),
  -- Use `[g` and `]g` to navigate diagnostics
  -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  ['n|[g'] = cmd('<Plug>(coc-diagnostic-prev)'):silent(),
  ['n|]g'] = cmd('<Plug>(coc-diagnostic-next)'):silent(),
  -- Symbol renaming.
  ['n|<leader>rn'] = cmd('<Plug>(coc-rename)'):silent(),
  -- Formating
  ['n|<leader>f'] = cmd('<Plug>(coc-format)'):silent(),
  ['x|<leader>f'] = cmd('<Plug>(coc-format-selected)'):silent(),
  -- Apply AutoFix to problem on the current line.
  ['n|<leader>qf'] = cmd('<Plug>(coc-fix-current)'):silent(),
  -- coc-translator --
  ['n|tt'] = cmd('<Plug>(coc-translator-p)'):silent(),
  ['v|tt'] = cmd('<Plug>(coc-translator-pv)'):silent(),

  -------------------
  -- telescope-coc --
  -------------------
  ['n|<space>a'] = cr('Telescope coc diagnostics'):silent(),
  ['n|<space>A'] = cr('Telescope coc workspace_diagnostics'):silent(),
  ['n|<space>s'] = cr('Telescope coc document_symbols'):silent(),
  ['n|<space>S'] = cr('Telescope coc workspace_symbols'):silent(),
  ['n|<space>c'] = cr('Telescope coc commands'):silent(),
  ['n|<space>d'] = cr('Telescope coc definitions'):silent(),
}
-- inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

wxy.highlight('CocRustTypeHint', 'Comment')
