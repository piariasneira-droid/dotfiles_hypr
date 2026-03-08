# ══════════════════════════════════════════════════════
# HYPRLAND — colors.conf
# ══════════════════════════════════════════════════════

write_file "hypr/colors.conf" \
"### =====================================================
### $THEME_NAME — Hyprland Border Colors
### AUTO-GENERATED — do not edit manually.
### Edit ${THEME_SLUG}.conf and re-run generate.sh
### =====================================================

general {
    border_size = 2
    col.active_border   = 0xFF${ACCENT0}
    col.inactive_border = 0xFF${BG3}
    gaps_in  = 8
    gaps_out = 4
}

decoration {
    rounding = 8
}"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/conf.d/colors.conf" \
    "$THEME_OUTPUT_DIR/hypr/colors.conf"