#!/usr/bin/env bash
# =====================================================
# THEME SWITCHER
# =====================================================

set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GENERATE="$THEME_DIR/generate.sh"
WALLPAPERS_DIR="$THEME_DIR/wallpapers"

# ── Collect available themes ──────────────────────────
mapfile -t CONF_FILES < <(find "$THEME_DIR" -maxdepth 1 -name "*.conf" | sort)

if [[ ${#CONF_FILES[@]} -eq 0 ]]; then
    echo "✗ No .conf files found in $THEME_DIR"
    exit 1
fi

# ── Read current active slug ───────────────────────────
ACTIVE_LINK="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/active.rasi"
CURRENT_SLUG=""
if [[ -L "$ACTIVE_LINK" ]]; then
    link_target="$(readlink "$ACTIVE_LINK")"
    CURRENT_SLUG="$(basename "$(dirname "$(dirname "$link_target")")")"
fi

# ── Build maps ────────────────────────────────────────
declare -A SLUG_TO_NAME
declare -A NAME_TO_SLUG
MENU_ENTRIES=()

for f in "${CONF_FILES[@]}"; do
    slug="$(basename "$f" .conf)"
    name="$(bash -c "source '$f'; echo \"\$THEME_NAME\"")"
    SLUG_TO_NAME["$slug"]="$name"
    NAME_TO_SLUG["$name"]="$slug"
    [[ "$slug" == "$CURRENT_SLUG" ]] && MENU_ENTRIES+=("  $name") || MENU_ENTRIES+=("    $name")
done

# ── Resolve target theme ──────────────────────────────
if [[ $# -ge 1 ]]; then
    TARGET_SLUG="$1"
else
    CHOSEN="$(printf '%s\n' "${MENU_ENTRIES[@]}" | rofi -dmenu -p "🎨 Theme" -i -no-custom)"
    [[ -z "$CHOSEN" ]] && exit 0
    CHOSEN_NAME="${CHOSEN#"${CHOSEN%%[! ]*}"}"
    TARGET_SLUG="${NAME_TO_SLUG[$CHOSEN_NAME]}"
fi

# ── Generate Theme Files ──────────────────────────────
echo "🎨 Switching to: ${SLUG_TO_NAME[$TARGET_SLUG]}"
bash "$GENERATE" --theme "${TARGET_SLUG}.conf"

# ── . RELOAD HYPRLAND ────────────────────────────────
if command -v hyprctl &>/dev/null; then
    echo "→ Reloading Hyprland"
    hyprctl reload
fi

hyprctl hyprpaper wallpaper ",/home/pivan/Themes/wallpapers/active"

# ── Restart waybar ────────────────────────────────────
WAYBAR_SCRIPT="$HOME/.config/hypr/scripts/execwaybar.sh"
if [[ -x "$WAYBAR_SCRIPT" ]]; then
    echo "→ Restarting waybar"
    bash "$WAYBAR_SCRIPT" && echo "  ✓ Waybar restarted"

elif command -v waybar &>/dev/null; then
    echo "→ Restarting waybar (pkill + relaunch)"
    pkill waybar 2>/dev/null || true
    sleep 0.3
    waybar &>/dev/null &
    disown
    echo "  ✓ Waybar relaunched"
fi

# ── Restart dunst ──────────────────────────────────────
if pgrep -x "dunst" > /dev/null; then
    echo "  → Restarting Dunst to apply new colors..."
    pkill dunst
    sleep 0.2 
    dunst &
fi

# ── Restart nwg-dock ──────────────────────────────────
if pgrep -x "nwg-dock-hyprla" > /dev/null; then
    echo "→ Refreshing Dock"
    pkill -9 nwg-dock-hyprla 
    sleep 0.5
    
    # Use full path for rofi if needed, and wrap the command clearly
    nwg-dock-hyprland -i 48 -p bottom -a center -r -l "rofi -show drun" -s "$HOME/.config/nwg-dock-hyprland/style.css" & 
    
    disown
    echo "  ✓ Dock restarted with launcher"
fi

echo "✅ Done!"