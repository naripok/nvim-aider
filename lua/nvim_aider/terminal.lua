local M = {}

local config = require("nvim_aider.config")

local function create_cmd(opts)
  local cmd = { "aider" }
  vim.list_extend(cmd, opts.args or {})
  return table.concat(cmd, " ")
end

local function create_terminal(opts)
  local toggleterm = require("toggleterm")
  local Terminal = require("toggleterm.terminal").Terminal
  return Terminal:new({
    cmd = create_cmd(opts),
    direction = "vertical",
  })
end

function M.toggle(opts)
  if vim.fn.executable("aider") == 0 then
    vim.notify("aider executable not found in PATH", vim.log.levels.ERROR)
    return
  end
  opts = vim.tbl_deep_extend("force", config.options, opts or {})
  local term = create_terminal(opts)
  term:toggle(100)
end

---Send text to terminal
---@param text string Text to send
---@param opts? nvim_aider.Config  
---@param multi_line? boolean
function M.send(text, opts, multi_line)
  if vim.fn.executable("aider") == 0 then
    vim.notify("aider executable not found in PATH", vim.log.levels.ERROR)
    return
  end

  multi_line = multi_line == nil and true or multi_line
  opts = vim.tbl_deep_extend("force", config.options, opts or {})

  local term = create_terminal(opts)

  if not term then
    vim.notify("Could not create Aider terminal.", vim.log.levels.ERROR)
    return
  end

  local bufnr = term:_get_bufnr()
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    local chan = vim.api.nvim_buf_get_var(bufnr, "terminal_job_id")
    if chan then
      if multi_line then
        -- Use bracketed paste sequences
        local bracket_start = "\27[200~"
        local bracket_end = "\27[201~\r"
        local bracketed_text = bracket_start .. text .. bracket_end
        vim.api.nvim_chan_send(chan, bracketed_text)
      else
        text = text:gsub("\n", " ") .. "\n"
        vim.api.nvim_chan_send(chan, text)
      end
    else
      vim.notify("No Aider terminal job found!", vim.log.levels.ERROR)
    end
  else
    vim.notify("Please open an Aider terminal first.", vim.log.levels.INFO)
  end
end

---@param command string Aidar command
---@param text? string Text to send
---@param opts? nvim_aider.Config
function M.command(command, text, opts)
  text = text or ""
  opts = vim.tbl_deep_extend("force", config.options, opts or {})
  -- NOTE: For Aider commands that shouldn't get a newline (e.g. `/add file`)
  M.send(command .. " " .. text, opts, false)
end

return M
