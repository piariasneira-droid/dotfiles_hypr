# ══════════════════════════════════════════════════════
# WLOGOUT — style.css
# ══════════════════════════════════════════════════════

# ── Generate the CSS ──────────────────────────────────
write_file "wlogout/style.css" \
"/* =====================================================
 * $THEME_NAME — Wlogout Style
 * AUTO-GENERATED — do not edit manually.
 * ===================================================== */

window {
    background-color: rgba($BG0_A90);
}

button {
    background-color: #$BG2;
    color: #$FG0;
    border-radius: 20px;
    border: 3px solid #$BG3;
    background-repeat: no-repeat;
    background-position: center;
    background-size: 25%;
}

button:focus, 
button:active, 
button:hover {
    background-color: #$ACCENT0;
    color: #$BG0;
    border: 3px solid #$ACCENT2;
}

/* Specific icon button identifiers (matching layout file) */
#lock {
    background-image: image(url(\"/usr/share/wlogout/icons/lock.png\"));
}
#logout {
    background-image: image(url(\"/usr/share/wlogout/icons/logout.png\"));
}
#suspend {
    background-image: image(url(\"/usr/share/wlogout/icons/suspend.png\"));
}
#hibernate {
    background-image: image(url(\"/usr/share/wlogout/icons/hibernate.png\"));
}
#shutdown {
    background-image: image(url(\"/usr/share/wlogout/icons/shutdown.png\"));
}
#reboot {
    background-image: image(url(\"/usr/share/wlogout/icons/reboot.png\"));
}"

# ── Create Default Layout if missing ──────────────────
WLOGOUT_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wlogout"
if [[ ! -f "$WLOGOUT_CONFIG_DIR/layout" ]]; then
    mkdir -p "$WLOGOUT_CONFIG_DIR"
    cat <<EOF > "$WLOGOUT_CONFIG_DIR/layout"
{
    "label" : "lock",
    "action" : "hyprlock",
    "text" : "Lock",
    "keybind" : "l"
}
{
    "label" : "hibernate",
    "action" : "systemctl hibernate",
    "text" : "Hibernate",
    "keybind" : "h"
}
{
    "label" : "logout",
    "action" : "hyprctl dispatch exit 0",
    "text" : "Logout",
    "keybind" : "e"
}
{
    "label" : "shutdown",
    "action" : "systemctl poweroff",
    "text" : "Shutdown",
    "keybind" : "s"
}
{
    "label" : "suspend",
    "action" : "systemctl suspend",
    "text" : "Suspend",
    "keybind" : "u"
}
{
    "label" : "reboot",
    "action" : "systemctl reboot",
    "text" : "Reboot",
    "keybind" : "r"
}
EOF
fi

# ── Deploy ────────────────────────────────────────────
_deploy_symlink \
    "$WLOGOUT_CONFIG_DIR/style.css" \
    "$THEME_OUTPUT_DIR/wlogout/style.css"