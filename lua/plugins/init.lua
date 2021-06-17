local cmd = vim.cmd
local fn = vim.fn

local function conf(name)
  return string.format("require('plugins.%s')", name)
end

-- automaticlly install packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  cmd("packadd packer.nvim")
end
cmd([[packadd packer.nvim]])

local packer = require("packer")

packer.init({
  git = { clone_timeout = 120 },
  -- disable_commands = true
})
packer.startup(function(use)
  -- packer
  use({ "wbthomason/packer.nvim" })

  use("kyazdani42/nvim-web-devicons")

  -- colorscheme
  use({
    { "sainnhe/sonokai" },
    { "sainnhe/edge" },
    { "monsonjeremy/onedark.nvim" },
    { "shaunsingh/nord.nvim" },
    { "xiyaowong/nvim-transparent", config = conf("transparent") },
  })
  -- File Tree
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    config = conf("nvim-tree"),
  })
  -- UI
  use({
    { "akinsho/nvim-bufferline.lua", config = conf("nvim-bufferline") },
    { "hoob3rt/lualine.nvim", config = "require('statusline')" },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufRead", "InsertEnter" },
      branch = "lua",
      config = conf("indent-blakline"),
    },
  })
  -- lsp, completion
  use({
    {
      "neoclide/coc.nvim",
      branch = "release",
      event = { "InsertEnter", "BufRead" },
      config = conf("coc"),
    },
    "honza/vim-snippets",
  })
  -- Enhance
  use({
    "antoinemadec/FixCursorHold.nvim",
    -- Vim-cool disables search highlighting when you are done searching
    -- and re-enables it when you search again.
    { "romainl/vim-cool", event = "BufRead" },
    { "rhysd/accelerated-jk" },
    { "kana/vim-niceblock", event = "BufRead" },
    {
      "nacro90/numb.nvim",
      event = "CmdlineEnter",
      config = function()
        require("numb").setup()
      end,
    },
    {
      "karb94/neoscroll.nvim",
      event = "BufRead",
      keys = { "<C-f>", "<C-b>" },
      config = function()
        require("neoscroll").setup({
          mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "zt", "zz", "zb" },
        })
      end,
    },
    { "itchyny/vim-cursorword", event = "BufRead" },
  })

  use({ "junegunn/vim-easy-align", event = "BufRead" })
  use({ "talek/obvious-resize", config = "vim.g.obvious_resize_default = 2" }) -- resize window
  use({
    "b3nj5m1n/kommentary",
    event = { "BufRead", "InsertEnter" },
    config = function()
      require("kommentary.config").configure_language("lua", { prefer_single_line_comments = true })
    end,
  })
  use({ "tpope/vim-surround", event = { "BufRead", "InsertEnter" } })
  --Movement
  use({
    { "rhysd/clever-f.vim", event = "BufRead" },
    {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopLine", "HopPattern", "HopChar1" },
      config = function()
        require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      end,
    },
  })
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/auto/",
      })
    end,
  })
  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({ "*" }, {
        names = false,
        mode = "background",
      })
    end,
  })
  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        close_triple_quotes = true,
        check_ts = false,
      })
    end,
  })
  use({
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    config = conf("neogit"),
  })
  use({
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    requires = "nvim-lua/plenary.nvim",
    config = conf("gitsigns"),
  })
  use({ "folke/zen-mode.nvim", cmd = "ZenMode" })
  use({
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUI",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
    },
    requires = { "tpope/vim-dadbod" },
    config = function()
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 40
    end,
  })
  use({
    "iamcco/markdown-preview.nvim",
    run = ":call mkdp#util#install()",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  })
  -- treesitter
  use({
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = conf("nvim-treesitter"),
    },
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
  })

  use({ "liuchengxu/vista.vim", cmd = "Vista", config = conf("vista") })
  use({
    "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    config = conf("nvim-toggleterm"),
  })
  use({ "sindrets/diffview.nvim", cmd = "DiffviewOpen", config = conf("diffview") })

  use({
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = conf("telescope"),
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    },
    "fannheyward/telescope-coc.nvim",
  })

  use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })
end)

cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
