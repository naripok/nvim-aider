local M = {}

M.config = require("nvim_aider.config")
M.terminal = require("nvim_aider.terminal")

---@param opts? nvim_aider.Config
function M.setup(opts)
  local commands = require("nvim_aider.commands")
  local utils = require("nvim_aider.utils")

  M.config.setup(opts)

  vim.api.nvim_create_user_command("AiderTerminalToggle", function()
    M.terminal.toggle()
  end, {})

  vim.api.nvim_create_user_command("AiderTerminalSend", function(args)
    if args.args == "" then
      vim.ui.input({ prompt = "Send to Aider: " }, function(input)
        if input then
          M.terminal.send(input)
        end
      end)
    else
      M.terminal.send(args.args)
    end
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("AiderQuickAddFile", function()
    local relative_filepath = utils.get_relative_path()
    if relative_filepath == nil then
      vim.notify("No valid file in current buffer", vim.log.levels.INFO)
    else
      M.terminal.command(commands.add.value, relative_filepath)
    end
  end, {})

  vim.api.nvim_create_user_command("AiderQuickDropFile", function()
    local relative_filepath = utils.get_relative_path()
    if relative_filepath == nil then
      vim.notify("No valid file in current buffer", vim.log.levels.INFO)
    else
      M.terminal.command(commands.drop.value, relative_filepath)
    end
  end, {})
end

return M
