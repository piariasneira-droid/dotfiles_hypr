#!/bin/bash
# Cicla por todas las ventanas de todos los workspaces
# Uso: cycle-windows.sh [prev]

DIRECTION=${1:-next}

# Obtener todas las ventanas ordenadas por workspace y luego por address
CLIENTS=$(hyprctl clients -j)
ADDRESSES=$(echo "$CLIENTS" | jq -r 'sort_by(.workspace.id, .address) | .[].address')
FOCUSED=$(hyprctl activewindow -j | jq -r '.address')

# Convertir a array
mapfile -t ADDRS <<< "$ADDRESSES"
COUNT=${#ADDRS[@]}

if [ "$COUNT" -eq 0 ]; then exit 1; fi

# Encontrar índice actual
CURRENT=-1
for i in "${!ADDRS[@]}"; do
    if [ "${ADDRS[$i]}" = "$FOCUSED" ]; then
        CURRENT=$i
        break
    fi
done

# Calcular siguiente/anterior
if [ "$DIRECTION" = "prev" ]; then
    TARGET=$(( (CURRENT - 1 + COUNT) % COUNT ))
else
    TARGET=$(( (CURRENT + 1) % COUNT ))
fi

TARGET_ADDR=${ADDRS[$TARGET]}

# Cambiar al workspace de la ventana destino y enfocarla
TARGET_WS=$(echo "$CLIENTS" | jq -r --arg addr "$TARGET_ADDR" '.[] | select(.address == $addr) | .workspace.id')
hyprctl dispatch workspace "$TARGET_WS"
hyprctl dispatch focuswindow "address:$TARGET_ADDR"