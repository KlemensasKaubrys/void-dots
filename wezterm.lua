-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()


-- wezterm ls-fonts --list-system
config.font = wezterm.font {
  family = 'JetBrainsMono Nerd Font',
}
config.font_size = 13 
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Italic" }),
	},
}
config.front_end = "OpenGL"
config.freetype_load_target = 'Light'
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500  
config.animation_fps = 30
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'


config.initial_cols = 120 
config.initial_rows = 40 

-- shell
config.default_prog = { "bash" }

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
	}

config.color_scheme = 'Tokyo Night'
config.colors = {
 foreground = '#ffffff',
 cursor_fg = '#ffffff'

}

config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true 
return config
