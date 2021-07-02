require("bufferline").setup({
  options = {
    modified_icon = "✥",
    show_buffer_close_icons = false,
    show_close_icon = false,
    mappings = true,
    always_show_bufferline = true,
    offsets = {
      { filetype = "NvimTree", text = "FILE EXPLORER", text_align = "center" },
      { filetype = "vista", text = "SYMBOLS AND TAGS", text_align = "center" },
    },
  },
})
