local fn, cmd = vim.fn, vim.cmd

local cache_theme_path = CACHE_PATH .. 'theme'
local default_theme = 'onedark'

-- Must be set before loading the theme, otherwise, it won't have any effect.
local theme_configs = {
  sonokai = function()
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_style = 'atlantis'
    vim.g.sonokai_sign_column_background = 'none'
    vim.g.sonokai_diagnostic_text_highlight = 1
    -- vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = 'colored'
  end,
  edge = function()
    vim.g.edge_better_performance = 1
    vim.g.edge_style = 'aura'
    vim.g.edge_sign_column_background = 'none'
    vim.g.edge_diagnostic_text_highlight = 1
    -- vim.g.edge_diagnostic_line_highlight = 1
    vim.g.edge_diagnostic_virtual_text = 'colored'
  end,
  ['gruvbox-material'] = function()
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_sign_column_background = 'none'
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  end,
  onedark = function()
    -- vim.g.onedark_transparent = true
    vim.g.onedark_sidebars = { 'qf', 'vista', 'terminal', 'packer' }
  end,
}

local function setup()
  if not vim.g.colors_name then
    local theme
    if fn.empty(cache_theme_path) > 0 then
      theme = default_theme
    else
      theme = fn.readfile(cache_theme_path)[1]
    end
    if theme_configs[theme] then
      theme_configs[theme]()
    end
    cmd('colorscheme ' .. theme)
  end
end

local function cache()
  if vim.g.colors_name then
    fn.writefile({ vim.g.colors_name }, cache_theme_path)
  end
end

local function clean()
  if vim.g.colors_name then
    cmd [[highlight clear]]
  end
end

wxy.autocmd {
  {
    'ColorSchemePre',
    clean,
    '*',
  },
  {
    'ColorScheme',
    cache,
    '*',
  },
}

setup()
