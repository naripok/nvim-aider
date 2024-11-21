local M = {}

M.config = require("nvim_aider.config")
M.terminal = require("nvim_aider.terminal")

---@param opts? nvim_aider.Config
function M.setup(opts)
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
end

return M
