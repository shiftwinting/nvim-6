require("neogit").setup({
  {
    disable_signs = false,
    signs = {
      section = { "", "" }, -- "", ""
      item = { "▸", "▾" },
      hunk = { "樂", "" },
    },
    integrations = {
      diffview = true,
    },
  },
})
