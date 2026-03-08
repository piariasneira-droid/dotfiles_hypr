# ══════════════════════════════════════════════════════
# HYPRLOCK — config
# ══════════════════════════════════════════════════════

write_file "hyprlock/hyprlock.conf" \
"# =====================================================
# $THEME_NAME — Hyprlock Config
# AUTO-GENERATED — do not edit manually.
# Edit ${THEME_SLUG}.conf and re-run generate.sh
# =====================================================

general {
    disable_loading_bar = false
    hide_cursor         = true
    grace               = 0
    no_fade_in          = false
}

# ── Background ────────────────────────────────────────
background {
    monitor     =
    path        = $WALLPAPERS_DIR/active
    blur_passes = 0
    brightness  = 1.0
    contrast    = 1.0
    vibrancy    = 0.0
}

# ── Clock ─────────────────────────────────────────────
label {
    monitor     =
    text        = cmd[update:1000] echo \"\$(date +\"%H:%M\")\"
    color       = rgb($FG0)
    font_size   = 72
    font_family = JetBrainsMono Nerd Font Bold

    position = 0, 120
    halign   = center
    valign   = center
}

label {
    monitor     =
    text        = cmd[update:60000] echo \"\$(date +\"%A, %B %d\")\"
    color       = rgb($FG1)
    font_size   = 20
    font_family = JetBrainsMono Nerd Font

    position = 0, 40
    halign   = center
    valign   = center
}

# ── Password input ────────────────────────────────────
input-field {
    monitor  =
    size     = 280, 52

    outline_thickness = 2
    dots_size         = 0.26
    dots_spacing      = 0.18
    dots_center       = true

    outer_color       = rgb($ACCENT1)
    inner_color       = rgb($BG1)
    font_color        = rgb($FG0)
    fade_on_empty     = true

    check_color       = rgb($ACCENT2)
    fail_color        = rgb($RED)

    placeholder_text  = <i>password…</i>
    fail_text         = <i>incorrect</i>

    position = 0, -80
    halign   = center
    valign   = center
}

# ── User label ────────────────────────────────────────
label {
    monitor     =
    text        = \$USER
    color       = rgb($FG1)
    font_size   = 14
    font_family = JetBrainsMono Nerd Font

    position = 0, -140
    halign   = center
    valign   = center
}"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock.conf" \
    "$THEME_OUTPUT_DIR/hyprlock/hyprlock.conf"
