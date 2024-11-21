# [![aider](https://avatars.githubusercontent.com/u/172139148?s=20&v=4)](https://aider.chat) nvim-aider

🤖 Seamlessly integrate Aider with Neovim for an enhanced AI-assisted coding experience!

![screenshot_1](https://github.com/user-attachments/assets/5d779f73-5441-4d24-8cce-e6dfdc5bf787)

> 🚧 This plugin is in initial development. Expect breaking changes and rough edges.

## 🌟 Features

- [x] 🖥️ Aider terminal integration within Neovim
- [x] 🎨 Color theme configuration support with auto Catppuccin flavor synchronization
      if available
- [ ] 📤 Send buffers, selections, or file names to Aider

## 🎮 Commands

- ⌨️ `AiderTerminalToggle` - Toggle the Aider terminal window
- 📤 `AiderTerminalSend [text]` - Send text to Aider
  - Without arguments: Opens input prompt
  - With arguments: Sends provided text directly

## 🔗 Dependencies

🐍 Python: Install `aider`  
🌙 Lua: `folke/snacks.nvim`, _optionals_ `catppuccin/nvim`

## 📦 Installation

Using lazy.nvim:

```lua
{
    "GeorgesAlkhouri/nvim-aider",
    cmd = {
      "AiderTerminalToggle",
    },
    keys = {
      { "<leader>z", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
    },
    dependencies = {
      "folke/snacks.nvim",
      --- The below dependencies are optional
      "catppuccin/nvim",
    },
    config = true,
  }
```

## ⚙️ Configuration

There is no need to call setup if you don't want to change the default options.

```lua
require("nvim_aider").setup({
  -- Command line arguments passed to aider
  args = {
    "--no-auto-commits",
    "--pretty",
    "--stream",
  },

  -- Theme colors (automatically uses Catppuccin flavor if available)
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

  -- Other snacks.terminal.Opts options
  config = {
    os = { editPreset = "nvim-remote" },
    gui = { nerdFontsVersion = "3" },
  },

  win = {
    style = "nvim_aider",
    position = "bottom",
  },
})
```

---

<div align="center">
Made with 🤖 using <a href="https://github.com/paul-gauthier/aider">Aider</a>
</div>
