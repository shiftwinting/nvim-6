local cmd = vim.cmd
local fn = vim.fn

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
		{ "rakr/vim-one" },
		{ "sainnhe/sonokai" },
		{ "sainnhe/edge" },
		{ "arcticicestudio/nord-vim" },
	})
	-- File Tree
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen" },
		config = [[require('config.nvim-tree')]],
	})
	-- UI
	use({
		-- Bufferline
		{
			"akinsho/nvim-bufferline.lua",
			config = [[require('config.nvim-bufferline')]],
		},
		-- dashboard
		{ "glepnir/dashboard-nvim", config = [[require('config.dashboard')]] },
		-- statusline
		{ "glepnir/galaxyline.nvim", config = [[require('statusline')]] },
		-- indent line
		{
			"Yggdroot/indentLine",
			event = "BufReadPre",
			config = [[require('config.indentLine')]],
		},
		-- rainbow pairs
		{ "luochen1990/rainbow", event = "BufReadPre", setup = [[vim.g.rainbow_active = 1]] },
	})
	-- completion
	use({
		{
			"neoclide/coc.nvim",
			branch = "release",
			config = [[require('config.coc')]],
		},
		"honza/vim-snippets",
	})
	-- Enhance
	use({
		-- Vim-cool disables search highlighting when you are done searching
		-- and re-enables it when you search again.
		{ "romainl/vim-cool", event = "BufReadPre" },
		{ "rhysd/accelerated-jk" },
		{ "kana/vim-niceblock", event = "BufReadPre" },
		"rhysd/clever-f.vim",
		{
			"psliwka/vim-smoothie",
			setup = [[vim.g.smoothie_no_default_mappings = true]],
			event = "BufReadPre",
		},
		{ "lfv89/vim-interestingwords", event = "BufReadPre" },
		{ "itchyny/vim-cursorword", event = "BufReadPre" },
	})

	use({ "junegunn/vim-easy-align", event = "BufReadPre" })
	-- use({ "mhartington/formatter.nvim", config = [[require('config.format')]] })
	use({ "farmergreg/vim-lastplace" })
	use({
		"camspiers/animate.vim",
		{
			"camspiers/lens.vim",
			setup = function()
				vim.cmd("let g:lens#disabled_filetypes = ['NvimTree', 'dashboard']")
			end,
		},
	})
	use({
		{ "tyru/caw.vim", event = "BufReadPre", requires = "Shougo/context_filetype.vim" },
		{ "tpope/vim-surround", event = "BufReadPre" },
	})

	--Movement
	use({
		{ "matze/vim-move", event = "BufReadPre" },
		{
			"chaoren/vim-wordmotion",
			event = "BufReadPre",
			{ "easymotion/vim-easymotion", config = [[require('config.easymotion')]] },
		},
	})
	-- syntax
	use({
		"nvim-treesitter/nvim-treesitter",
		config = [[require('config.nvim-treesitter')]],
		ft = {
			"python",
			"go",
			"javascript",
			"typescript",
			"html",
			"css",
			"rust",
			"toml",
			"lua",
			"vue",
			"yaml",
		},
	})
	use({
		{ "cespare/vim-toml", fy = "toml" },
		{ "neoclide/jsonc.vim", ft = "jsonc" },
		{ "dart-lang/dart-vim-plugin", ft = "dart" },
		{ "raimon49/requirements.txt.vim", ft = "requirements" },
		{ "johejo/gomod.vim", ft = "gomod" },
		{ "MTDL9/vim-log-highlighting", ft = "log" },
		{ "fannheyward/go.vim", ft = "go" },
		{ "rust-lang/rust.vim", ft = "rust" },
	})
	use({ "skywind3000/asyncrun.vim", cmd = "AsyncRun" })
	use({
		"liuchengxu/vista.vim",
		cmd = { "Vista" },
		config = [[require('config.vista')]],
	})
	use({
		"akinsho/nvim-toggleterm.lua",
		cmd = "ToggleTerm",
		config = [[require('config.nvim-toggleterm')]],
	})
	-- fuzzy finder
	use({
		{
			"liuchengxu/vim-clap",
			run = ":Clap install-binary!",
			cmd = "Clap",
			config = [[require('config.vim-clap')]],
		},
		{ "vn-ki/coc-clap", after = { "vim-clap", "coc.nvim" } },
	})
end)

cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
