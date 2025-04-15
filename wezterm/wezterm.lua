local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the resizbale border
	default_cursor_style = "BlinkingBar",
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	font = wezterm.font("Iosevka Nerd Font Mono", {weight="Bold", stretch="Normal", style="Normal"}), -- (AKA: Iosevka NFM, Iosevka NFM Medium Obl) /Users/jayrgarg/Library/Fonts/IosevkaNerdFontMono-MediumOblique.ttf, CoreText --wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 12.5,
	color_scheme = 'Red Sands (Gogh)',-- 'Dracula (Official)',--'Lunaria Light (Gogh)',--"Nord (Gogh)",
 	background = {
        {
			source = {
				File = "/Users/jayrgarg/Pictures/backgrounds/future-city.png",
			},
			width = "100%",
			height = "100%",
		},
        {
            source = {
                Color = "black",--"#282c35",
            },
            width = "100%",
            height = "100%",
            opacity = 0.85,
        },
    },
	window_padding = {
		left = 5,
		right = 5,
--		top = 0,
--		bottom = 0,
	},
}

return config
