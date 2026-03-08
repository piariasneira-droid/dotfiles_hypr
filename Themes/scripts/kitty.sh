# ══════════════════════════════════════════════════════
# KITTY — kitty.conf
# ══════════════════════════════════════════════════════

write_file "kitty/kitty.conf" \
"# =====================================================
# $THEME_NAME — Kitty Config
# AUTO-GENERATED — do not edit manually.
# Edit ${THEME_SLUG}.conf and re-run generate.sh
# =====================================================

font_family      JetBrainsMono Nerd Font
font_size        11.0
window_padding_width 12
confirm_os_window_close 0

# Transparency
background_opacity 0.95
dynamic_background_opacity yes

# Colors
background       #$BG0
foreground       #$FG0
cursor           #$FG0
selection_background #$BG3
selection_foreground #$FG0

# Tabs
active_tab_background   #$ACCENT0
active_tab_foreground   #$BG0
inactive_tab_background #$BG2
inactive_tab_foreground #$FG1

# Terminal Colors
color0 #$BG3
color1 #$RED
color2 #$ACCENT0
color3 #$YELLOW
color4 #$ACCENT_SEC
color5 #$ACCENT_SEC
color6 #$ACCENT1
color7 #$FG1

color8  #$BG2
color9  #$RED
color10 #$ACCENT2
color11 #$ORANGE
color12 #$ACCENT_SEC
color13 #$ACCENT_SEC
color14 #$ACCENT1
color15 #$FG0"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf" \
    "$THEME_OUTPUT_DIR/kitty/kitty.conf"