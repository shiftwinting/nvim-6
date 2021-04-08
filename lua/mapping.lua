local utils = require("utils")
local map = utils.map

silent = { silent = true }

---------
-- Basic
---------
map("n", "s", "")
map("i", "jj", "<esc>`^")
-- Save buffer
map("n", "<leader>s", "<cmd>w<cr>", silent)
-- Switch window
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
-- delete inline words
map("n", "dl", "D")
map("n", "dh", "d0x")
--
map("n", "<space><space>", "zz")
-- Insert new line
map("i", "<C-l>", "<C-o>A")
map("i", "<C-j>", "<C-o>o")
map("i", "<C-k>", "<C-o>O")
-- Indent
map("x", "<", "<gv")
map("x", ">", ">gv")
-- Backspace
map("i", "<C-d>", "<Del>")
map("i", "<C-h>", "<BS>")
-- quickly change word
map("i", "<C-w>", "<C-o>ciw")
-- yank
map("n", "Y", "y$")

------------------------- Plugins Mappings ------------------------
-- nvim tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", silent)
map("n", "<leader>F", "<cmd>NvimTreeFindFile<CR>", silent)
-- vista
map("n", "<leader>v", "<cmd>Vista!!<CR>")
-- easy align
map({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
-- acelerated jk (enhanced jk move)
map("n", "j", "<Plug>(accelerated_jk_gj)", { noremap = false })
map("n", "k", "<Plug>(accelerated_jk_gk)", { noremap = false })
-- vim-clap
map("n", "<space>tc", ":<C-u>Clap colors<CR>", silent)
map("n", "<space>bb", ":<C-u>Clap buffers<CR>", silent)
map("n", "<space>fa ", ":<C-u>Clap grep2<CR>", silent)
map("n", "<space>fb", ":<C-u>Clap marks<CR>", silent)
map("n", "<C-x><C-f>", ":<C-u>Clap filer<CR>", silent)
map("n", "<space>ff", ":<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>", silent)
map("n", "<space>fg", ":<C-u>Clap gfiles<CR>", silent)
map("n", "<space>fw", ":<C-u>Clap grep ++query=<cword><cr>", silent)
map("n", "<space>fh", ":<C-u>Clap history<CR>", silent)
map("n", "<space>fW", ":<C-u>Clap windows<CR>", silent)
map("n", "<space>fl", ":<C-u>Clap loclist<CR>", silent)
map("n", "<space>fu", ":<C-u>Clap git_diff_files<CR>", silent)
map("n", "<space>fv", ":<C-u>Clap grep ++query=@visual<CR>", silent)
map("n", "<space>oc", ":<C-u>Clap personalconf<CR>", silent)
-- coc-clap
-- Show all diagnostics
map("n", "<space>a", ":Clap coc_diagnostics<CR>", silent)
-- Manage extensions
map("n", "<space>e", ":Clap coc_extensions<CR>", silent)
-- Show commands
map("n", "<space>c", ":Clap coc_commands<CR>", silent)
-- Search workspace symbols
map("n", "<space>s", ":Clap coc_symbols<CR>", silent)
map("n", "<space>S", ":Clap coc_services<CR>", silent)
map("n", "<space>o", ":Clap coc_outline<CR>", silent)
----- Nvim Bufferline
map("n", "<leader>b", ":BufferLinePick<CR>", silent)
map("n", "]b", ":BufferLineCycleNext<CR>", silent)
map("n", "[b", ":BufferLineCyclePrev<CR>", silent)
--- Nvim toggleterm
map({ "n", "t" }, "<leader>t", ":ToggleTerm<CR>", silent)
----- COC ------
-- Use K for show documentation in float window
map("n", "K", ":call CocActionAsync('doHover')<CR>", silent)
-- Applying codeAction to the selected region.
map({ "x", "n" }, "<leader>a", "<Plug>(coc-codeaction-selected)", { noremap = false, silent = true })
-- " Use <c-q> for trigger completion.
map("i", "<c-q>", "coc#refresh()", { silent = true, expr = true })
-- " Jump definition in other window
-- Remap keys for gotos
map("n", "gd", [[:vsplit|normal\<Plug>(coc-definition)<CR>]], silent)
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true, noremap = false })
map("n", "<Leader>ci", "<Plug>(coc-implementation)", { silent = true, noremap = false })
map("n", "gr", "<Plug>(coc-references)", { silent = true, noremap = false })
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true, noremap = false })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true, noremap = false })
-- Symbol renaming.
map("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, noremap = false })
-- Format current buffer
map({ "n", "x" }, "<leader>f", "<Plug>(coc-format)", { silent = true, noremap = false })
-- Apply AutoFix to problem on the current line.
map("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true, noremap = false })
-- Map function and class text objects
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", { silent = true, noremap = false })
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", { silent = true, noremap = false })
map({ "x", "o" }, "ic", "<Plug>(coc-classobj-i)", { silent = true, noremap = false })
map({ "x", "o" }, "ac", "<Plug>(coc-classobj-a)", { silent = true, noremap = false })
-----coc-translator----
map("n", "tt", "<Plug>(coc-translator-p)", { silent = true, noremap = false })
map("v", "tt", "<Plug>(coc-translator-pv)", { silent = true, noremap = false })

--- vim-smoothie
map("n", "<C-f>", ":<C-U>call smoothie#forwards()<CR>", silent)
map("n", "<C-b>", ":<C-U>call smoothie#backwards()<CR>", silent)
map("n", "<C-d>", ":<C-U>call smoothie#downwards()<CR>", silent)
map("n", "<C-u>", ":<C-U>call smoothie#upwards()<CR>", silent)