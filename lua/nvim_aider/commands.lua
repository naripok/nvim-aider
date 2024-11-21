---@alias CommandCategory "input"|"direct"

---@class Command
---@field value string
---@field description string
---@field category CommandCategory

local COMMAND_PREFIX = "/"
local commands = {
  add = {
    value = COMMAND_PREFIX .. "add",
    description = "Add files to the chat for editing or detailed review",
    category = "input",
  },
  architect = {
    value = COMMAND_PREFIX .. "architect",
    description = "Enter architect mode for high-level design discussions",
    category = "direct",
  },
  ask = {
    value = COMMAND_PREFIX .. "ask",
    description = "Ask questions about the codebase without editing files",
    category = "input",
  },
  ["chat-mode"] = {
    value = COMMAND_PREFIX .. "chat-mode",
    description = "Switch to a new chat mode",
    category = "input",
  },
  clear = {
    value = COMMAND_PREFIX .. "clear",
    description = "Clear the chat history",
    category = "direct",
  },
  code = {
    value = COMMAND_PREFIX .. "code",
    description = "Request changes to your code",
    category = "input",
  },
  commit = {
    value = COMMAND_PREFIX .. "commit",
    description = "Commit edits made outside the chat to the repo",
    category = "direct",
  },
  copy = {
    value = COMMAND_PREFIX .. "copy",
    description = "Copy the last assistant message to clipboard",
    category = "direct",
  },
  diff = {
    value = COMMAND_PREFIX .. "diff",
    description = "Display changes diff since the last message",
    category = "direct",
  },
  drop = {
    value = COMMAND_PREFIX .. "drop",
    description = "Remove files from chat session to free context space",
    category = "direct",
  },
  exit = {
    value = COMMAND_PREFIX .. "exit",
    description = "Exit the application",
    category = "direct",
  },
  git = {
    value = COMMAND_PREFIX .. "git",
    description = "Run a git command (output excluded from chat)",
    category = "input",
  },
  help = {
    value = COMMAND_PREFIX .. "help",
    description = "Ask questions about aider",
    category = "input",
  },
  lint = {
    value = COMMAND_PREFIX .. "lint",
    description = "Lint and fix in-chat files or all dirty files",
    category = "direct",
  },
  load = {
    value = COMMAND_PREFIX .. "load",
    description = "Load and execute commands from a file",
    category = "input",
  },
  ls = {
    value = COMMAND_PREFIX .. "ls",
    description = "List known files and their chat session status",
    category = "direct",
  },
  map = {
    value = COMMAND_PREFIX .. "map",
    description = "Print the current repository map",
    category = "direct",
  },
  ["map-refresh"] = {
    value = COMMAND_PREFIX .. "map-refresh",
    description = "Force a refresh of the repository map",
    category = "direct",
  },
  model = {
    value = COMMAND_PREFIX .. "model",
    description = "Switch to a new LLM",
    category = "input",
  },
  models = {
    value = COMMAND_PREFIX .. "models",
    description = "Search the list of available models",
    category = "direct",
  },
  paste = {
    value = COMMAND_PREFIX .. "paste",
    description = "Paste image/text from clipboard into chat",
    category = "direct",
  },
  quit = {
    value = COMMAND_PREFIX .. "quit",
    description = "Exit the application",
    category = "direct",
  },
  ["read-only"] = {
    value = COMMAND_PREFIX .. "read-only",
    description = "Add reference files to chat, not for editing",
    category = "input",
  },
  report = {
    value = COMMAND_PREFIX .. "report",
    description = "Report a problem by opening a GitHub Issue",
    category = "direct",
  },
  reset = {
    value = COMMAND_PREFIX .. "reset",
    description = "Drop all files and clear chat history",
    category = "direct",
  },
  run = {
    value = COMMAND_PREFIX .. "run",
    description = "Run a shell command, optionally add output to chat",
    category = "input",
  },
  save = {
    value = COMMAND_PREFIX .. "save",
    description = "Save commands to reconstruct current chat session",
    category = "direct",
  },
  settings = {
    value = COMMAND_PREFIX .. "settings",
    description = "Print current settings",
    category = "direct",
  },
  test = {
    value = COMMAND_PREFIX .. "test",
    description = "Run command, add output to chat on non-zero exit",
    category = "input",
  },
  tokens = {
    value = COMMAND_PREFIX .. "tokens",
    description = "Report tokens used by current chat context",
    category = "direct",
  },
  undo = {
    value = COMMAND_PREFIX .. "undo",
    description = "Undo last git commit if done by aider",
    category = "direct",
  },
  voice = {
    value = COMMAND_PREFIX .. "voice",
    description = "Record and transcribe voice input",
    category = "direct",
  },
  web = {
    value = COMMAND_PREFIX .. "web",
    description = "Scrape webpage, convert to markdown, send in message",
    category = "input",
  },
}

return commands
