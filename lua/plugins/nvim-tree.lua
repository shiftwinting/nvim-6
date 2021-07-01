local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache", "__pycache__" }
vim.g.nvim_tree_bindings = {
  { key = "s", cb = tree_cb("vsplit") },
  { key = "i", cb = tree_cb("split") },
}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "✚",
    staged = "✚",
    unmerged = "≠",
    renamed = "≫",
    untracked = "★",
  },
  folder = { default = "", open = "" },
}
