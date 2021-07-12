local packer_path = DATA_PATH .. '/pack/packer/opt/packer.nvim'
if not vim.loop.fs_stat(packer_path) then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end
vim.cmd [[packadd packer.nvim]]

---------------------------------------

local loaded = false
local function load()
  loaded = true

  local packer = require 'packer'
  packer.init {
    git = { clone_timeout = 120 },
    display = {
      open_fn = require('packer.util').float,
    },
    compile_path = CONFIG_PATH .. '/plugin/packer_compiled.lua',
    disable_commands = true,
  }
  packer.startup(function(use)
    local all = {}

    local plugins = require 'wongxy.plugins.use'
    for name, plugin in pairs(plugins) do
      if type(plugin) == 'table' then
        table.insert(plugin, name)
      end
      table.insert(all, plugin)
    end

    use(all)
  end)
end

vim.api.nvim_exec(
  [[
    command! PackerInstall           lua require('wongxy.plugins').install()
    command! PackerUpdate            lua require('wongxy.plugins').update()
    command! PackerSync              lua require('wongxy.plugins').sync()
    command! PackerClean             lua require('wongxy.plugins').clean()
    command! -nargs=* PackerCompile  lua require('wongxy.plugins').compile(<q-args>)
    command! PackerStatus            lua require('wongxy.plugins').status()
    command! PackerProfile           lua require('wongxy.plugins').profile_output()
    command! -nargs=+ -complete=customlist,v:lua.require'packer'.loader_complete PackerLoad lua require('wongxy.plugins').loader(<q-args>)
]],
  false
)

return setmetatable({}, {
  __index = function(_, key)
    if not loaded then
      load()
    end
    return require('packer')[key]
  end,
})
