local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    sorting_strategy = 'descending',
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
  extesions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      mappings = {
        i = { ['<c-x>'] = actions.delete_buffer },
        n = { ['<c-x>'] = actions.delete_buffer },
      },
    },
    colorscheme = {
      enable_preview = true,
    },
    git_branches = {
      theme = 'dropdown',
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'coc'
telescope.load_extension 'emoji'
