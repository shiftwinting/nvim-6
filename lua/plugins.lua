local cmd = vim.cmd
local fn = vim.fn

local function conf(name)
  return string.format("require('config.%s')", name)
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
    { "Mofiqul/codedark.nvim" },
    { "sainnhe/sonokai" },
    { "monsonjeremy/onedark.nvim" },
    { "sainnhe/edge" },
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
      event = "BufRead",
      branch = "lua",
      config = conf("indent-blakline"),
    },
  })
  -- lsp, completion
  use({
    { "neoclide/coc.nvim", branch = "release", config = conf("coc") },
    "honza/vim-snippets",
  })
  -- Enhance
  use({
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
      config = function()
        require("neoscroll").setup({
          mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "zt", "zz", "zb" },
        })
      end,
    },
    { "lfv89/vim-interestingwords", event = "BufRead" },
    { "itchyny/vim-cursorword", event = "BufRead" },
  })

  use({ "junegunn/vim-easy-align", event = "BufRead" })
  use({ "talek/obvious-resize", config = "vim.g.obvious_resize_default = 2" }) -- resize window
  use({
    "b3nj5m1n/kommentary",
    event = "BufRead",
    config = function()
      require("kommentary.config").configure_language("lua", { prefer_single_line_comments = true })
    end,
  })
  use({ "tpope/vim-surround", event = "BufRead" })
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
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
    config = conf("neogit"),
  })
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
  use({
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = conf("telescope"),
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    },
    "fannheyward/telescope-coc.nvim",
  })
end)

cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
