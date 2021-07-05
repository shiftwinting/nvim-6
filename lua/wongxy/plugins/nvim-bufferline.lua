require("bufferline").setup({
  options = {
    modified_icon = "✥",
    show_buffer_close_icons = false,
    show_close_icon = false,
    mappings = true,
    always_show_bufferline = true,
    offsets = {
      { filetype = "NvimTree", text = "FILE EXPLORER", padding = 1, highlight = "Directory" },
      { filetype = "vista", text = "SYMBOLS AND TAGS", padding = 1 },
    },
  },
})
