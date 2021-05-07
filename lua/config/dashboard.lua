local global = require("global")

vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_disable_statusline = 1
-- vim.g.dashboard_footer_icon = '🐬 '
vim.g.dashboard_preview_command = "cat"
vim.g.dashboard_preview_pipeline = "lolcat --animate --speed 100 -d 1"

local files = vim.fn.split(vim.fn.glob(global.vim_path .. "static/*.cat"), "\n")
math.randomseed(os.time())
local file = files[math.random(1, #files)]
local height = tonumber(file:match([[(%d+)%-%d+]]))
local width = tonumber(file:match([[%d+%-(%d+)]]))

vim.g.dashboard_preview_file = file
vim.g.dashboard_preview_file_height = height
vim.g.dashboard_preview_file_width = width
vim.g.dashboard_custom_footer = { "" }
vim.g.dashboard_custom_section = {
  a_new_file = {
    description = { "  New file                                " },
    command = "DashboardNewFile",
  },
  b_find_file = {
    description = { "  Find  file                       SPC f f" },
    command = "DashboardFindFile",
  },
  c_find_word = {
    description = { "  Find  word                       SPC f w" },
    command = "DashboardFindWord",
  },
  d_find_history = {
    description = { "  Recently opened files            SPC f h" },
    command = "DashboardFindHistory",
  },
  e_jump_bookmarks = {
    description = { "  Jump to bookmarks                SPC f m" },
    command = "DashboardJumpMarks",
  },
  f_last_session = {
    description = { "  Recently laset session           SPC s l" },
    command = "SessionLoad",
  },
  g_change_color = {
    description = { "  Change colorscheme               SPC t c" },
    command = "DashboardChangeColorscheme",
  },
}

vim.cmd([[autocmd FileType dashboard nnoremap <buffer> q ZZ]])
