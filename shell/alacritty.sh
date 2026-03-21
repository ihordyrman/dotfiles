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
# Copyright (c) 2016-present Sven Greb <development@svengreb.de>
# This source code is licensed under the MIT license found in the license file.

[colors.primary]
background = "#2e3440"
foreground = "#d8dee9"
dim_foreground = "#a5abb6"

[colors.cursor]
text = "#2e3440"
cursor = "#d8dee9"

[colors.vi_mode_cursor]
text = "#2e3440"
cursor = "#d8dee9"

[colors.selection]
text = "CellForeground"
background = "#4c566a"

[colors.search.matches]
foreground = "CellBackground"
background = "#88c0d0"

[colors.normal]
black = "#3b4252"
red = "#bf616a"
green = "#a3be8c"
yellow = "#ebcb8b"
blue = "#81a1c1"
magenta = "#b48ead"
cyan = "#88c0d0"
white = "#e5e9f0"

[colors.bright]
black = "#4c566a"
red = "#bf616a"
green = "#a3be8c"
yellow = "#ebcb8b"
blue = "#81a1c1"
magenta = "#b48ead"
cyan = "#8fbcbb"
white = "#eceff4"

[colors.dim]
black = "#373e4d"
red = "#94545d"
green = "#809575"
yellow = "#b29e75"
blue = "#68809a"
magenta = "#8c738c"
cyan = "#6d96a5"
white = "#aeb3bb"
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/font.toml
[font]
normal = { family = "JetBrainsMono Nerd Font Mono", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font Mono", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font Mono", style = "Italic" }
size = 9
EOF
