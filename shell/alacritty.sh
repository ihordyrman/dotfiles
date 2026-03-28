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
# Colors (Everforest Light)

# Default colors
[colors.primary]
background = '#fdf6e3'
foreground = '#5c6a72'

# Normal colors
[colors.normal]
black = '#5c6a72'
red = '#f85552'
green = '#8da101'
yellow = '#dfa000'
blue = '#3a94c5'
magenta = '#df69ba'
cyan = '#35a77c'
white = '#e0dcc7'

# Bright Colors
[colors.bright]
black = '#5c6a72'
red = '#f85552'
green = '#8da101'
yellow = '#dfa000'
blue = '#3a94c5'
magenta = '#df69ba'
cyan = '#35a77c'
white = '#e0dcc7'
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/font.toml
[font]
normal = { family = "JetBrainsMono Nerd Font Mono", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font Mono", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font Mono", style = "Italic" }
size = 11
EOF
