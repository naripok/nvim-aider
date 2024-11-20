---@alias nvim_aider.Color string

---@class nvim_aider.Theme: table<string, nvim_aider.Color>
---@field user_input_color nvim_aider.Color
---@field tool_output_color nvim_aider.Color
---@field tool_error_color nvim_aider.Color
---@field tool_warning_color nvim_aider.Color
---@field assistant_output_color nvim_aider.Color
---@field completion_menu_color nvim_aider.Color
---@field completion_menu_bg_color nvim_aider.Color
---@field completion_menu_current_color nvim_aider.Color
---@field completion_menu_current_bg_color nvim_aider.Color

---@class nvim_aider.Config: snacks.terminal.Opts
---@field args? string[]
---@field theme? nvim_aider.Theme
local M = {}

M.defaults = {
  args = {
    "--no-auto-commits",
    "--pretty",
    "--stream",
  },
  config = {
    os = { editPreset = "nvim-remote" },
    gui = { nerdFontsVersion = "3" },
  },
  theme = {
    user_input_color = "#a6da95",
    tool_output_color = "#8aadf4",
    tool_error_color = "#ed8796",
    tool_warning_color = "#eed49f",
    assistant_output_color = "#c6a0f6",
    completion_menu_color = "#cad3f5",
    completion_menu_bg_color = "#24273a",
    completion_menu_current_color = "#181926",
    completion_menu_current_bg_color = "#f4dbd6",
  },
  win = {
    style = "nvim_aider",
    position = "bottom",
  },
}

---@type nvim_aider.Config
M.options = vim.deepcopy(M.defaults)

---Update config with user options
---@param opts? nvim_aider.Config
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
  Snacks.config.style("nvim_aider", {})
  return M.options
end

return M
