#!/bin/bash

set -e

INSTALL_DIR="$HOME/bin"
AUTO_YES="no"

if [ "$1" = "-y" ] || [ "$1" = "--yes" ]; then
AUTO_YES="yes"
fi

echo "===== Jaewoong Linux Tools Uninstaller ====="
echo
echo "Install directory:"
echo "$INSTALL_DIR"
echo

echo "Tools to remove:"
echo "- jcheck"
echo "- jgrep"
echo "- jnote"
echo

if [ "$AUTO_YES" != "yes" ]; then
echo "Do you want to remove these tools from $INSTALL_DIR? [y/n]"
read -r answer

if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
echo "Uninstall canceled."
exit 0
fi
fi

for tool in jcheck jgrep jnote
do
target="$INSTALL_DIR/$tool"

if [ -f "$target" ]; then
rm "$target"
echo "Removed: $target"
else
echo "Not installed: $target"
fi
done

echo
echo "Uninstall completed."
