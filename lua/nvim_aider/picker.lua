---@class nvim_aider.picker
local M = {}
local config = require("nvim_aider.config")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

---@param opts? nvim_aider.Config
---@param confirm? fun(picker: table, item: table)
function M.create(opts, confirm)
  opts = vim.tbl_deep_extend("force", config.options, opts or {})
  -- Build items from commands
  local items = {}
  local longest_cmd = 0
  for cmd_name, cmd_data in pairs(require("nvim_aider.commands")) do
    table.insert(items, {
      text = cmd_data.value,
      description = cmd_data.description,
      category = cmd_data.category,
      name = cmd_name,
    })
    longest_cmd = math.max(longest_cmd, #cmd_data.value)
  end
  longest_cmd = longest_cmd + 2

  pickers.new(opts.picker_cfg or {}, {
    prompt_title = "Aider Commands",
    finder = finders.new_table({
      results = items,
      entry_maker = function(item)
        return {
          value = item,
          display = item.text .. " " .. item.description,
          ordinal = item.text .. " " .. item.description,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts.picker_cfg or {}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if confirm then
          confirm(nil, selection.value)
        end
      end)
      return true
    end,
  }):find()
end

return M
