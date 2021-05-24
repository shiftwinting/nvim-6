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
    -- cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    config = conf("nvim-tree"),
  })
  -- UI
  use({
    -- Bufferline
    { "akinsho/nvim-bufferline.lua", config = conf("nvim-bufferline") },
    -- dashboard
    { "glepnir/dashboard-nvim", config = conf("dashboard") },
    -- statusline
    { "glepnir/galaxyline.nvim", config = "require('statusline')" },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      branch = "lua",
      config = conf("indent-blakline"),
    },
    -- rainbow pairs
    {
      "luochen1990/rainbow",
      event = "BufReadPre",
      setup = "vim.g.rainbow_active = 1",
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
  use({ "farmergreg/vim-lastplace" })
  use({ "talek/obvious-resize", config = "vim.g.obvious_resize_default = 2" }) -- resize window
  use({
    { "tyru/caw.vim", event = "BufRead", requires = "Shougo/context_filetype.vim" },
    { "tpope/vim-surround", event = "BufRead" },
  })
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
  -- syntax
  use({
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = conf("nvim-treesitter"),
  })
  use({
    { "raimon49/requirements.txt.vim", ft = "requirements" },
    { "johejo/gomod.vim", ft = "gomod" },
    { "MTDL9/vim-log-highlighting", ft = "log" },
  })
  use({ "skywind3000/asyncrun.vim", cmd = "AsyncRun" })
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
