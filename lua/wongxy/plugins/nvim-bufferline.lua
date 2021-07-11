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
    custom_areas = {
      right = function()
        return {
          {
            text = vim.g.github_notifications or "",
            guibg = wxy.hi_value("BufferLineBackground", "bg"),
          },
        }
      end,
    },
  },
})

-- Credit: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/statusline/utils.lua

---A thin wrapper around nvim's job api
---@param interval number
---@param task function
---@param on_complete function?
---@diagnostic disable-next-line: unused-function
local function job(interval, task, on_complete)
  vim.defer_fn(task, 2000)
  local pending_job
  local timer = vim.fn.timer_start(interval, function()
    -- clear previous job
    if pending_job then
      vim.fn.jobstop(pending_job)
    end
    pending_job = task()
  end, {
    ["repeat"] = -1,
  })
  if on_complete then
    on_complete(timer)
  end
end

---Validate the response from the github CLI is JSON
---@param data table
---@return boolean
local function validate_github_response(data)
  return vim.tbl_islist(data)
    and not wxy.empty(data[1])
    and type(data[1]) == "string"
    and not data[1]:match("<!DOCTYPE html>")
end

---@diagnostic disable-next-line: unused-function
local function fetch_github_notifications()
  vim.fn.jobstart("gh api notifications", {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      if data then
        vim.defer_fn(function()
          -- data is a table, so check that the first value isn't an empty string
          if validate_github_response(data) then
            local notifications = vim.fn.json_decode(data)
            vim.g.github_notifications = #notifications > 0 and " " .. #notifications or ""
          end
        end, 1)
      end
    end,
  })
end

local function github_notifications()
  if vim.fn.executable("gh") > 0 then
    job(300000, fetch_github_notifications)
  end
end

vim.defer_fn(github_notifications, 1)
