# ══════════════════════════════════════════════════════
# DUNST — dunstrc
# ══════════════════════════════════════════════════════

write_file "dunst/dunstrc" \
"[global]
    ### Display ###
    monitor = 0
    follow = mouse
    
    # Bubble Geometry
    width = 350
    height = 110
    origin = top-right
    offset = 20x20
    scale = 0
    notification_limit = 5
    
    # The "Bubble" effect: High corner radius
    corner_radius = 15
    
    # Visual Styling
    transparency = 10
    padding = 15
    horizontal_padding = 15
    text_icon_padding = 10
    frame_width = 2
    frame_color = \"#$ACCENT0\"
    separator_color = frame
    
    # Text & Fonts
    font = JetBrainsMono Nerd Font 11
    line_height = 0
    format = \"<b>%s</b>\\n%b\"
    alignment = left
    vertical_alignment = center
    show_indicators = yes
    
    # Icons
    enable_recursive_icon_lookup = true
    icon_position = left
    min_icon_size = 32
    max_icon_size = 64

[urgency_low]
    background = \"#$BG0\"
    foreground = \"#$FG1\"
    frame_color = \"#$BG3\"
    timeout = 5

[urgency_normal]
    background = \"#$BG0\"
    foreground = \"#$FG0\"
    frame_color = \"#$ACCENT0\"
    timeout = 10

[urgency_critical]
    background = \"#$BG0\"
    foreground = \"#$RED\"
    frame_color = \"#$RED\"
    timeout = 0"

# ── Deploy ────────────────────────────────────────────
# Symlinks the generated dunstrc to your config folder
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/dunst/dunstrc" \
    "$THEME_OUTPUT_DIR/dunst/dunstrc"