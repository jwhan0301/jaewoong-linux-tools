#!/bin/bash

set -e

INSTALL_DIR="$HOME/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "===== Jaewoong Linux Tools Installer ====="
echo

mkdir -p "$INSTALL_DIR"

for tool in jcheck jgrep jnote
do
    if [ -f "$SCRIPT_DIR/$tool" ]; then
        cp "$SCRIPT_DIR/$tool" "$INSTALL_DIR/$tool"
        chmod +x "$INSTALL_DIR/$tool"
        echo "Installed: $tool -> $INSTALL_DIR/$tool"
    else
        echo "Missing file: $tool"
        exit 1
    fi
done

echo
echo "Installation completed."
echo "Make sure this path is in your PATH:"
echo "$INSTALL_DIR"
