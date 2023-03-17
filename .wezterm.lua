-- -------------------------------------------------------------------
-- rxyhn's aesthetic wezterm configuration
-- A GPU-accelerated cross-platform terminal emulator and multiplexer
--
-- https://github.com/rxyhn
-- -------------------------------------------------------------------

local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "FiraCode Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font"

return {
	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",

	-- Font config
	font = font_with_fallback(font_name),
	font_rules = {
		{
			italic = true,
            font = font_with_fallback(font_name, { italic = true }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(font_name, { italic = true, bold = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true, foreground = 'SandyBrown' }),
		},
	},
	warn_about_missing_glyphs = false,
	font_size = 10.5,
	line_height = 1.0,

	-- Cursor style
	default_cursor_style = "BlinkingBlock",

	-- X11
	enable_wayland = false,

	-- Keybinds
	disable_default_key_bindings = true,
	keys = {
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DecreaseFontSize
        },
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.IncreaseFontSize
		},
		{
			key = [[\]],
			mods = "CTRL|ALT",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "ALT",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{ -- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "x",
			mods = "CTRL|SHIFT",
			action = "ActivateCopyMode",
		},
		{
			key = "F",
			mods = "CTRL|SHIFT",
			action = wezterm.action({Search = {CaseInSensitiveString = '' }})
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
	},

	-- Aesthetic Night Colorscheme
	bold_brightens_ansi_colors = true,
    -- color_scheme = "Raycast_Dark",
    color_scheme = "tokyonight",
	colors = {
		-- foreground = "#edeff0",
		-- background = "#0c0e0f",
		-- cursor_bg = "#c3c7c8",
		-- cursor_fg = "black",
		-- cursor_border = "#232526",
		-- selection_fg = "#0c0e0f",
		-- selection_bg = "#edeff0",
		-- scrollbar_thumb = "#a39fa1",
		-- split = "#090909",
		-- ansi = { "#232526", "#df5b61", "#78b892", "#dead5a", "#6791c9", "#bc83e3", "#67afc1", "#e4e6e7" },
		-- brights = { "#2c2e2f", "#e8646a", "#81c19b", "#e7b663", "#709ad2", "#c58cec", "#70b8ca", "#f2f4f5" },
		indexed = { [136] = "#edeff0" },
		tab_bar = {
			active_tab = {
				bg_color = "#1e1e1e",
				fg_color = "#edeff0",
				italic = true,
			},
			inactive_tab = { bg_color = "black", fg_color = "#404243" },
			inactive_tab_hover = { bg_color = "#3d373d", fg_color = "#70b8ca" },
			new_tab = { bg_color = "#1d1d1d", fg_color = "#3b3b3b" },
			new_tab_hover = { bg_color = "#6791c9", fg_color = "#090909" },
		},
	},

	-- Padding
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = true,
	tab_bar_at_bottom = true,

	-- General
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 0.85,
	window_close_confirmation = "NeverPrompt",
	window_frame = { active_titlebar_bg = "#090909", font = wezterm.font{family = 'FiraCode NF', weight = 'Bold'}, font_size = 10.5 },
}
