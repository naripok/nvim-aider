local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local commands = require("nvim_aider.commands")
local entry_display = require("telescope.pickers.entry_display")

local terminal = require("nvim_aider.terminal").terminal

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 18 },
    { remaining = true },
  },
})
local make_display = function(entry)
  return displayer({
    entry.name,
    -- entry.category,
    entry.description,
  })
end

return function(opts, on_selection)
  opts = opts or {}

  local _commands = {}
  for cmd_name, cmd_config in pairs(commands) do
    table.insert(_commands, { cmd_name, cmd_config })
  end

  pickers
    .new(opts, {
      prompt_title = "Aider '/' commands",
      finder = finders.new_table({
        results = _commands,
        entry_maker = function(element)
          return {
            -- TODO: adjust sorting and make weight on commands name and than description
            ordinal = element[1] .. " " .. element[2].description,
            display = make_display,
            name = element[1],
            value = element[2].value,
            category = element[2].category,
            description = element[2].description,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          on_selection(selection)
        end)
        return true
      end,
    })
    :find()
end
-- commands_ui(require("telescope.themes").get_dropdown({}))
