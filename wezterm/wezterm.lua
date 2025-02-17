local wezterm = require("wezterm")
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "OLEDppuccin"
  else
    return "deepwhite"
  end
end

local scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
scheme.background = "#000000"

return {
  -- colors
  color_schemes = {
    ["OLEDppuccin"] = scheme,
  },
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

  -- general styling
  enable_scroll_bar = false,

  -- fonts
  font = wezterm.font_with_fallback({
    { family = "CommitMono", weight = "Regular", stretch = "Normal", style = "Normal" },
    "FiraCode Nerd Font Mono",
  }),
  font_size = 18.0,
  use_cap_height_to_scale_fallback_fonts = true,
  harfbuzz_features = {
    "zero=1",
    "ss01=1",
    "ss02=1",
    "ss03=1",
    "ss04=1",
    "ss05=1",
    "ss06=1",
    "onum=0",
    "frac=0",
    "sups=0",
    "subs=0",
    "calt=1",
    "liga=1",
  },

  term = "wezterm",

  -- tab bar
  tab_max_width = 32,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  -- window
  show_update_window = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 10,
    bottom = 0,
  },

  -- bell
  audible_bell = "Disabled",
  visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 100,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 100,
  },

  -- general config
  clean_exit_codes = { 130 },
  automatically_reload_config = true,
  -- check_for_updates = false,

  keys = {
    -- disables command palette
    {
      key = "P",
      mods = "CTRL|SHIFT",
      action = wezterm.action_callback(function(window, pane)
        window:perform_action(wezterm.action.SendKey({ key = "p", mods = "CRTL|CTRL" }), pane)
      end),
    },
  },
}
