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
    local mode = vim.fn.mode()
    if vim.tbl_contains({ "v", "V", "" }, mode) then
      -- Visual mode behavior
      local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
      local selected_text = table.concat(lines, "\n")
      local file_type = vim.bo.filetype
      if file_type == "" then
        file_type = "text"
      end
      -- NOTE: add aider multiline tags
      selected_text = "{" .. file_type .. "\n" .. selected_text .. "\n" .. file_type .. "}"
      M.terminal.send(selected_text)
    else
      -- Normal mode behavior
      if args.args == "" then
        vim.ui.input({ prompt = "Send to Aider: " }, function(input)
          if input then
            M.terminal.send(input)
          end
        end)
      else
        M.terminal.send(args.args)
      end
    end
  end, { nargs = "?", range = true, desc = "Send text to Aider terminal" })

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
