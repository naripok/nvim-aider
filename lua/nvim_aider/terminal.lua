local config = require("nvim_aider.config")
local M = {}

---@class nvim_aider.terminal
local terminal = {}

---@type table<string, snacks.win>
local terminals = {}

-- Generate consistent terminal ID
---@param cmd? string[]
---@param opts? nvim_aider.Config
---@return string
local function get_terminal_id(cmd, opts)
	opts = opts or {}
	return vim.inspect({ cmd = cmd, cwd = opts.cwd, env = opts.env, count = vim.v.count1 })
end

---Get existing terminal
---@param cmd  string[]
---@param opts? nvim_aider.Config
---@return snacks.win|nil
local function get_terminal(cmd, opts)
	local id = get_terminal_id(cmd, opts)
	local term = terminals[id]
	return term and term:buf_valid() and term or nil
end

---Create command string list from options
---@param opts nvim_aider.Config
---@return string[]
local function create_cmd(opts)
	local cmd = { "aider" }
	vim.list_extend(cmd, opts.args or {})

	if opts.theme then
		for key, value in pairs(opts.theme) do
			table.insert(cmd, "--" .. key:gsub("_", "-"))
			table.insert(cmd, value)
		end
	end

	return cmd
end

---Toggle terminal visibility
---@param opts? nvim_aider.Config
---@return snacks.win
function terminal.toggle(opts)
	local snacks = require("snacks.terminal")

	opts = vim.tbl_deep_extend("force", config.options, opts or {})

	local cmd = create_cmd(opts)
	local term = get_terminal(cmd, opts)

	if term and term:buf_valid() then
		term:toggle()
		return term
	else
		term = snacks.toggle(cmd, opts)
		local id = get_terminal_id(cmd, opts)
		terminals[id] = term
		return term
	end
end

---Send text to terminal
---@param text string Text to send
---@param opts? nvim_aider.Config
---@param add_newline? boolean
function terminal.send(text, opts, add_newline)
	opts = vim.tbl_deep_extend("force", config.options, opts or {})

	if add_newline ~= false then
		text = text .. "\n"
	end

	local cmd = create_cmd(opts)
	local term = get_terminal(cmd, opts)
	if not term then
		vim.notify("Please open an Aider terminal fist.", vim.log.levels.INFO)
		return
	end

	if term and term:buf_valid() then
		local chan = vim.api.nvim_buf_get_var(term.buf, "terminal_job_id")
		if chan then
			vim.api.nvim_chan_send(chan, text)
		else
			vim.notify("No Aider terminal job found!", vim.log.levels.ERROR)
		end
	else
		vim.notify("Please open an Aider terminal fist.", vim.log.levels.INFO)
	end
end

M.terminal = terminal
M.terminal = terminal
return M
