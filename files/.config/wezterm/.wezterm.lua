local wezterm = require "wezterm"

local act = wezterm.action

local wsl_domains = wezterm.default_wsl_domains()
for _, dom in ipairs(wsl_domains) do
  dom.default_cwd = "~"
end

local config = {}

config.default_domain = "WSL:Ubuntu"
config.wsl_domains = wsl_domains

config.color_scheme = 'Kanagawa (Gogh)'
config.colors = {
  foreground = "#dcd7ba",
  background = "#181616",

  cursor_bg = "#c8c093",
  cursor_fg = "#2d4f67",
  cursor_border = "#c8c093",

  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",

  scrollbar_thumb = "#16161d",
  split = "#c8c093",

  ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
  brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

config.font = wezterm.font("UDEV Gothic 35NFLG", { weight = 600 })
config.font_size = 8
config.line_height = 1.3

config.window_decorations = "RESIZE"
config.initial_rows = 64
config.initial_cols = 150
config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "0cell",
  bottom = "0cell",
}

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.leader = { key = "t", mods = "CTRL" }
config.keys = {
  { key = "v", mods = "CTRL",   action = act.PasteFrom 'Clipboard' },
  { key = "c", mods = "CTRL",   action = act.CopyTo 'Clipboard' },

  { key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },
  { key = "v", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", cwd = "~" } } },
  { key = "'", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain", cwd = "~" } } },
  { key = "h", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "l", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "c", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain", cwd = "~" } },
  { key = "n", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
  { key = "p", mods = "LEADER", action = wezterm.action { ActivateTabRelative = -1 } },
  { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
  { key = "]", mods = "LEADER", action = act.PasteFrom 'Clipboard' },
  {
    key = "<",
    mods = "LEADER|SHIFT",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false },
      wezterm.action.AdjustPaneSize { "Left", 1 },
    }
  },
  {
    key = ">",
    mods = "LEADER|SHIFT",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false },
      wezterm.action.AdjustPaneSize { "Right", 1 },
    }
  },
  {
    key = "+",
    mods = "LEADER|SHIFT",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false },
      wezterm.action.AdjustPaneSize { "Up", 1 },
    }
  },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false },
      wezterm.action.AdjustPaneSize { "Down", 1 },
    }
  },
  {
    key = "q",
    mods = "LEADER",
    action = wezterm.action.PaneSelect {
      alphabet = "1234567890"
    }
  },
}
config.key_tables = {
  copy_mode = {
    { key = "Escape", mods = "NONE",  action = wezterm.action.CopyMode "Close" },
    {
      key = "Enter",
      mods = "NONE",
      action = wezterm.action.Multiple {
        { CopyTo = "ClipboardAndPrimarySelection" },
        wezterm.action.ClearSelection,
        { CopyMode = "Close" },
      },
    },
    { key = "0",      mods = "NONE",  action = wezterm.action.CopyMode "MoveToStartOfLine" },
    { key = "$",      mods = "SHIFT", action = wezterm.action.CopyMode "MoveToEndOfLineContent" },
    { key = "h",      mods = "NONE",  action = wezterm.action.CopyMode "MoveLeft" },
    { key = "j",      mods = "NONE",  action = wezterm.action.CopyMode "MoveDown" },
    { key = "k",      mods = "NONE",  action = wezterm.action.CopyMode "MoveUp" },
    { key = "l",      mods = "NONE",  action = wezterm.action.CopyMode "MoveRight" },
    { key = "w",      mods = "NONE",  action = wezterm.action.CopyMode "MoveForwardWord" },
    { key = "b",      mods = "NONE",  action = wezterm.action.CopyMode "MoveBackwardWord" },
    { key = "e",      mods = "NONE",  action = wezterm.action.CopyMode "MoveForwardWordEnd" },
    { key = "Space",  mods = "NONE",  action = wezterm.action.CopyMode { SetSelectionMode = "Cell" } },
    { key = "v",      mods = "NONE",  action = wezterm.action.CopyMode { SetSelectionMode = "Cell" } },
    { key = "v",      mods = "CTRL",  action = wezterm.action.CopyMode { SetSelectionMode = "Block" } },
    { key = "V",      mods = "SHIFT", action = wezterm.action.CopyMode { SetSelectionMode = "Line" } },
  },
}

return config
