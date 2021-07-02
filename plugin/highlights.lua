local function set()
  wxy.highlight_all({
    { "NvimNotificationError", { guifg = "#ec5f67" } },
    { "NvimNotificationInfo", { guifg = "#51afef" } },
  })
end

wxy.autocmd({ { "ColorScheme", set, "*" } })
