M = {}

---Gets the relative path of the current buffer
---This function retrieves the path relative to the current working directory
---
---@return string|nil path The relative path of the current buffer, or nil if:
---                      - The buffer is empty
---                      - The buffer has a special type (like terminal or help)
function M.get_relative_path()
  local buftype = vim.bo.buftype
  local filepath = vim.fn.expand("%")

  -- Check if buffer is empty or has special buftype
  if filepath == "" or buftype ~= "" then
    return nil
  else
    return vim.fn.expand("%:.")
  end
end

return M
