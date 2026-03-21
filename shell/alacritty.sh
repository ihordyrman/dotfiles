sudo apt install -y alacritty
mkdir -p ~/.config/alacritty

cat << 'EOF' | sudo tee ~/.config/alacritty/alacritty.toml
import = [ "~/.config/alacritty/theme.toml", "~/.config/alacritty/font.toml", "~/.config/alacritty/shared.toml" ]
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/shared.toml
[env]
TERM = "xterm-256color"

[shell]
program = "zellij"

[window]
dimensions.columns = 200
dimensions.lines = 40
padding.x = 12
padding.y = 10
decorations = "Full"
opacity = 0.98

[selection]
save_to_clipboard = true

[keyboard]
bindings = [
{ key = "F11", action = "ToggleFullscreen" }
]

[cursor]
style = { shape = "Block", blinking = "On" }
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/pane.toml
# Used by the About.desktop, Activity.desktop, Docker.desktop, Omakub.desktop, and Neovim.desktop apps
import = [ "~/.config/alacritty/theme.toml", "~/.config/alacritty/font.toml", "~/.config/alacritty/font-size.toml", "~/.config/alacritty/shared.toml" ]

[window]
padding.x = 30
padding.y = 30
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/btop.toml
# Used by the Activity.desktop app
import = [ "~/.config/alacritty/pane.toml" ]

[window]
dimensions.columns = 121
dimensions.lines = 40
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/theme.toml
# Colors section of "Alacritty - TOML configuration file format"
# https://github.com/alacritty/alacritty/blob/master/extra/man/alacritty.5.scd#colors

[colors.primary]
foreground = "#575279"
background = "#faf4ed"
dim_foreground = "#797593"
bright_foreground = "#575279"

[colors.cursor]
text = "#575279"
cursor = "#cecacd"

[colors.vi_mode_cursor]
text = "#575279"
cursor = "#cecacd"

[colors.search.matches]
foreground = "#797593"
background = "#f2e9e1"

[colors.search.focused_match]
foreground = "#faf4ed"
background = "#d7827e"

[colors.hints.start]
foreground = "#797593"
background = "#fffaf3"

[colors.hints.end]
foreground = "#9893a5"
background = "#fffaf3"

[colors.line_indicator]
foreground = "None"
background = "None"

[colors.footer_bar]
foreground = "#575279"
background = "#fffaf3"

[colors.selection]
text = "#575279"
background = "#dfdad9"

[colors.normal]
black = "#f2e9e1"
red = "#b4637a"
green = "#286983"
yellow = "#ea9d34"
blue = "#56949f"
magenta = "#907aa9"
cyan = "#d7827e"
white = "#575279"

[colors.bright]
black = "#9893a5"
red = "#b4637a"
green = "#286983"
yellow = "#ea9d34"
blue = "#56949f"
magenta = "#907aa9"
cyan = "#d7827e"
white = "#575279"

[colors.dim]
black = "#9893a5"
red = "#b4637a"
green = "#286983"
yellow = "#ea9d34"
blue = "#56949f"
magenta = "#907aa9"
cyan = "#d7827e"
white = "#575279"
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/font.toml
[font]
normal = { family = "JetBrainsMono Nerd Font Mono", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font Mono", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font Mono", style = "Italic" }
size = 9
EOF
