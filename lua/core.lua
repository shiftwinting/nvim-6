require("globals")
require("plugins")
require("options")
require("mappings")
require("autocmd")
require("colorscheme").init()

-- load profile.vim if existed
local profile = CONFIG_PATH .. "/profile.vim"
if vim.fn.filereadable(profile) > 0 then
	vim.cmd("source " .. profile)
end
