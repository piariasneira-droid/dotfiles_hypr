# ══════════════════════════════════════════════════════
# NWG-DOCK-HYPRLAND — style.css
# ══════════════════════════════════════════════════════

write_file "nwg-dock/style.css" \
"/* =====================================================
 * $THEME_NAME — Dock Styles
 * AUTO-GENERATED — do not edit manually.
 * ===================================================== */

window {
    background: rgba($WB_BACKGROUND); /* Using your Waybar bg for consistency */
    border-radius: 12px;
    border: 2px solid #$ACCENT1;
}

button {
    padding: 4px;
    margin: 4px;
    border-radius: 8px;
    transition: all 0.2s ease-in-out;
}

button:hover {
    background: rgba($WB_PRIMARY_CONTAINER);
    border: 1px solid #$ACCENT0;
}

/* Indicators for open windows */
button#app-button.running {
    border-bottom: 2px solid #$ACCENT0;
}

button#app-button.focused {
    background: #$ACCENT2;
}
"

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "${XDG_CONFIG_HOME:-$HOME/.config}/nwg-dock-hyprland/style.css" \
    "$THEME_OUTPUT_DIR/nwg-dock/style.css"