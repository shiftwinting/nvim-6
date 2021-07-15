local function conf(name)
  return string.format([[require("wongxy.plugins.%s")]], name)
end

return {
  -- packer
  ['wbthomason/packer.nvim'] = { opt = true },

  'kyazdani42/nvim-web-devicons',
  -- colorscheme
  'sainnhe/sonokai',
  'sainnhe/edge',
  'sainnhe/gruvbox-material',
  'monsonjeremy/onedark.nvim',
  ['xiyaowong/nvim-transparent'] = { config = conf 'transparent' },

  -- File Tree
  ['kyazdani42/nvim-tree.lua'] = {
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    config = conf 'nvim-tree',
  },

  -- UI
  ['akinsho/nvim-bufferline.lua'] = { event = 'VimEnter', config = conf 'nvim-bufferline' },

  ['lukas-reineke/indent-blankline.nvim'] = {
    event = { 'InsertEnter' },
    config = conf 'indent-blakline',
  },

  -- Enhance
  'tversteeg/registers.nvim',
  'rhysd/accelerated-jk',
  'antoinemadec/FixCursorHold.nvim',
  'xiyaowong/nvim-cursorword',
  ['romainl/vim-cool'] = { event = 'BufRead' },
  ['kana/vim-niceblock'] = { event = 'BufRead' },
  ['nacro90/numb.nvim'] = {
    event = 'CmdlineEnter',
    config = function()
      require('numb').setup()
    end,
  },
  ['karb94/neoscroll.nvim'] = {
    keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', 'zt', 'zz', 'zb' },
    config = function()
      require('neoscroll').setup {
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', 'zt', 'zz', 'zb' },
      }
    end,
  },
  ['talek/obvious-resize'] = { config = 'vim.g.obvious_resize_default = 2' },
  ['b3nj5m1n/kommentary'] = {
    event = { 'BufRead', 'InsertEnter' },
    config = function()
      require('kommentary.config').configure_language('lua', { prefer_single_line_comments = true })
    end,
  },
  ['blackCauldron7/surround.nvim'] = {
    event = { 'BufRead', 'InsertEnter' },
    config = function()
      require('surround').setup {
        mappings_style = 'surround',
      }
    end,
  },
  ['norcalli/nvim-colorizer.lua'] = {
    event = { 'BufRead' },
    config = function()
      require('colorizer').setup({ '*' }, {
        names = false,
        mode = 'background',
      })
    end,
  },
  ['windwp/nvim-autopairs'] = {
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        close_triple_quotes = true,
        check_ts = false,
      }
    end,
  },

  --Movement
  ['ggandor/lightspeed.nvim'] = { event = 'BufRead' },
  ['phaazon/hop.nvim'] = {
    cmd = { 'HopWord', 'HopLine', 'HopPattern', 'HopChar1' },
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
  },

  -- treesitter
  ['nvim-treesitter/nvim-treesitter'] = {
    event = { 'BufRead', 'InsertEnter' },
    config = conf 'nvim-treesitter',
  },
  ['p00f/nvim-ts-rainbow'] = { after = 'nvim-treesitter' },
  ['nvim-treesitter/nvim-treesitter-textobjects'] = { after = 'nvim-treesitter' },

  -- tools
  ['liuchengxu/vista.vim'] = { cmd = 'Vista', config = conf 'vista' },
  ['akinsho/nvim-toggleterm.lua'] = {
    cmd = { 'ToggleTerm', 'LazyGit' },
    config = conf 'nvim-toggleterm',
  },
  ['sindrets/diffview.nvim'] = { cmd = 'DiffviewOpen', config = conf 'diffview' },
  ['TimUntersberger/neogit'] = {
    requires = 'nvim-lua/plenary.nvim',
    cmd = 'Neogit',
    config = conf 'neogit',
  },
  ['lewis6991/gitsigns.nvim'] = {
    event = { 'TextChanged' },
    requires = 'nvim-lua/plenary.nvim',
    config = conf 'gitsigns',
  },
  ['iamcco/markdown-preview.nvim'] = {
    run = ':call mkdp#util#install()',
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },

  -- telescope
  ['nvim-telescope/telescope.nvim'] = {
    cmd = 'Telescope',
    config = conf 'telescope',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
  },
  'fannheyward/telescope-coc.nvim',
  'xiyaowong/telescope-emoji.nvim',

  -- lsp, completion
  ['neoclide/coc.nvim'] = {
    branch = 'release',
    event = { 'InsertEnter' },
    cmd = { 'CocStart', 'CocConfig', 'CocInstall', 'CocUninstall' },
    config = conf 'coc',
  },
  ['honza/vim-snippets'] = { event = 'InsertEnter' },

  -- profile
  ['tweekmonster/startuptime.vim'] = { cmd = 'StartupTime' },
}
