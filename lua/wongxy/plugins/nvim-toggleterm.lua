require('toggleterm').setup {
  size = 20,
  insert_mappings = false,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  persist_size = true,
  direction = 'float',
}

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new {
  cmd = 'lazygit',
  dir = 'git_dir',
  hidden = true,
  direction = 'float',
}

wxy.command {
  'LazyGit',
  function()
    lazygit:toggle()
  end,
}
