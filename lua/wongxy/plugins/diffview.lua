local cb = require('diffview.config').diffview_callback

require('diffview').setup {
  key_bindings = {
    file_panel = {
      ['q'] = '<Cmd>DiffviewClose<CR>',
      ['j'] = cb 'next_entry', -- Bring the cursor to the next file entry
      ['k'] = cb 'prev_entry', -- Bring the cursor to the previous file entry.
      ['<cr>'] = cb 'select_entry', -- Open the diff for the selected entry.
      ['o'] = cb 'select_entry',
      ['R'] = cb 'refresh_files', -- Update stats and entries in the file list.
      ['<leader>e'] = cb 'toggle_files',
      ['<tab>'] = cb 'select_next_entry',
      ['<s-tab>'] = cb 'select_prev_entry',
    },
    view = {
      ['q'] = '<Cmd>DiffviewClose<CR>',
      ['<tab>'] = cb 'select_next_entry', -- Open the diff for the next file
      ['<s-tab>'] = cb 'select_prev_entry',
      ['<leader>e'] = cb 'toggle_files',
      ['<leader>b'] = cb 'focus_files',
    },
  },
}
