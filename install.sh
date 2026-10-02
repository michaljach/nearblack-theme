#!/usr/bin/env bash
# Install or remove the NearBlack GNOME Shell theme and GTK color overrides.
# Usage: ./install.sh [--uninstall]
set -euo pipefail

cd "$(dirname "$0")"
THEMES="${XDG_DATA_HOME:-$HOME/.local/share}/themes"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
MARKER="NearBlack"

uninstall() {
  rm -rf "$THEMES/NearBlack" "$HOME/.themes/NearBlack"
  for v in gtk-4.0 gtk-3.0; do
    f="$CONFIG/$v/gtk.css"
    if [ -f "$f" ] && grep -q "$MARKER" "$f"; then
      rm "$f"
      [ -f "$f.bak" ] && mv "$f.bak" "$f"
    fi
  done
  if [ "$(dconf read /org/gnome/shell/extensions/user-theme/name)" = "'NearBlack'" ]; then
    dconf reset /org/gnome/shell/extensions/user-theme/name
  fi
  echo "NearBlack removed."
}

install() {
  mkdir -p "$THEMES"
  rm -rf "$THEMES/NearBlack"
  cp -r NearBlack "$THEMES/"

  for v in gtk-4.0 gtk-3.0; do
    f="$CONFIG/$v/gtk.css"
    mkdir -p "$CONFIG/$v"
    if [ -f "$f" ] && ! grep -q "$MARKER" "$f"; then
      mv "$f" "$f.bak"
      echo "Backed up existing $f to $f.bak"
    fi
    cp "$v/gtk.css" "$f"
  done

  if gnome-extensions list --enabled 2>/dev/null | grep -q '^user-theme@'; then
    dconf write /org/gnome/shell/extensions/user-theme/name "'NearBlack'"
    echo "NearBlack installed and activated."
  else
    echo "NearBlack installed. Enable the User Themes extension, then pick NearBlack in GNOME Tweaks."
  fi
  echo "Restart open apps to pick up the new colors."
}

case "${1:-}" in
  --uninstall) uninstall ;;
  "") install ;;
  *) echo "Usage: $0 [--uninstall]" >&2; exit 1 ;;
esac
