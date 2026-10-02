# NearBlack

A near-black theme for GNOME 50. It darkens the shell (top bar, overview, menus, Quick Settings, lock screen) and libadwaita/GTK apps such as Files.

| Area | Color |
| --- | --- |
| Top bar, overview, lock screen, app header bars | `#000000` |
| Popups, menus, app windows | `#0a0a0b` |
| App sidebars | `#111113` |
| Dialogs, popovers | `#131315` |

The shell theme is GNOME Shell 50's stock dark stylesheet with its greys remapped to near-black. Accent colors, text and icons are unchanged.

## Requirements

- GNOME Shell 50
- The [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension, for the shell part

## Install

```sh
git clone https://github.com/michaljach/nearblack-theme.git
cd nearblack-theme
./install.sh
```

Or download the tarball from the [latest release](https://github.com/michaljach/nearblack-theme/releases/latest), extract it and run `./install.sh`.

The script:

- copies the shell theme to `~/.local/share/themes/NearBlack`
- installs the app color overrides to `~/.config/gtk-4.0/gtk.css` and `~/.config/gtk-3.0/gtk.css`, backing up any existing file to `gtk.css.bak`
- activates the shell theme if User Themes is enabled

Restart open apps to see the new colors. Flatpak apps also need access to the GTK config:

```sh
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtk-3.0:ro
```

## Uninstall

```sh
./install.sh --uninstall
```

This removes the theme, restores any backed-up `gtk.css` and resets the shell theme to the default.

## License

GPL-3.0-or-later. The shell stylesheet is derived from [GNOME Shell](https://gitlab.gnome.org/GNOME/gnome-shell), which is GPL-2.0-or-later.
