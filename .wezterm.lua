local wezterm = require("wezterm")
local config = {}
local act = wezterm.action
local mux = wezterm.mux

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
-- windows only. Below will launch  wezterm with a shell running inside that Ubuntu distro.
-- rather than the default windows cmd.exe or powershell.exe
--config.default_domain = "WSL:Ununtu-20.04"
config.disable_default_mouse_bindings = false
config.disable_default_key_bindings = true
config.keys = {
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "1", mods = "SHIFT|CTRL", action = act.ActivateTab(0) },
	{ key = "2", mods = "SHIFT|CTRL", action = act.ActivateTab(1) },
	{ key = "3", mods = "SHIFT|CTRL", action = act.ActivateTab(2) },
	{ key = "4", mods = "SHIFT|CTRL", action = act.ActivateTab(3) },
	{ key = "5", mods = "SHIFT|CTRL", action = act.ActivateTab(4) },
	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	{ key = "LeftArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "LeftArrow", mods = "ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
	{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
	{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
}
config.font = wezterm.font("Hack Nerd Font Mono")
config.color_scheme = "Solarized Dark - Patched"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.initial_cols = 120
config.initial_rows = 40
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.6,
}
config.window_frame = {
	font = wezterm.font({ family = "Noto Sans", weight = "Regular" }),
}
wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- Set a workspace for coding on a current project
	-- Top pane is for the editor, bottom pane is for the build tool
	local tab, build_pane, window = mux.spawn_window({
		workspace = "coding",
		args = args,
	})
	window:gui_window():maximize()
	local editor_pane = build_pane:split({
		direction = "Right",
		size = 0.2,
	})
	build_pane:split({ direction = "Top" })
	-- We want to startup in the coding workspace
	mux.set_active_workspace("coding")
end)
return config
