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
# Nightfox Alacritty Colors
## name: dayfox
## upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/dayfox/alacritty.toml

[colors.primary]
background = "#f6f2ee"
foreground = "#3d2b5a"
dim_foreground = "#302b5d"
bright_foreground = "#643f61"

[colors.cursor]
text = "#3d2b5a"
cursor = "#643f61"

[colors.vi_mode_cursor]
text = "#3d2b5a"
cursor = "#287980"

[colors.search.matches]
foreground = "#3d2b5a"
background = "#a4c1c2"

[colors.search.focused_match]
foreground = "#3d2b5a"
background = "#396847"

[colors.footer_bar]
foreground = "#3d2b5a"
background = "#d3c7bb"

[colors.hints.start]
foreground = "#3d2b5a"
background = "#955f61"

[colors.hints.end]
foreground = "#3d2b5a"
background = "#d3c7bb"

[colors.selection]
text = "#3d2b5a"
background = "#e7d2be"

[colors.normal]
black = "#352c24"
red = "#a5222f"
green = "#396847"
yellow = "#ac5402"
blue = "#2848a9"
magenta = "#6e33ce"
cyan = "#287980"
white = "#f2e9e1"

[colors.bright]
black = "#534c45"
red = "#b3434e"
green = "#577f63"
yellow = "#b86e28"
blue = "#4863b6"
magenta = "#8452d5"
cyan = "#488d93"
white = "#f4ece6"

[colors.dim]
black = "#2d251f"
red = "#8c1d28"
green = "#30583c"
yellow = "#924702"
blue = "#223d90"
magenta = "#5e2baf"
cyan = "#22676d"
white = "#cec6bf"
EOF

cat << 'EOF' | sudo tee ~/.config/alacritty/font.toml
[font]
normal = { family = "JetBrainsMono Nerd Font Mono", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font Mono", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font Mono", style = "Italic" }
size = 9
EOF
