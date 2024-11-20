local M = {}

M.config = require("nvim_aider.config")

---@type nvim_aider.terminal
M.terminal = require("nvim_aider.terminal").terminal

---@param opts? nvim_aider.Config
function M.setup(opts)
	M.config.setup(opts)

	vim.api.nvim_create_user_command("AiderTerminalToggle", function()
		M.terminal.toggle()
	end, {})

	vim.api.nvim_create_user_command("AiderTerminalSend", function(args)
		M.terminal.send(args.args)
	end, { nargs = "+" })
end

return M
