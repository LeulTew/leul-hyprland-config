# Hyprland Configuration Backup

This repository contains a backup of my personal Hyprland setup on Fedora.

## Contents

- **`config/`**: Configuration files for Hyprland, Waybar, Kitty, Rofi, SwayNC, etc.
- **`.zshrc` / `.bashrc`**: Shell configurations.
- **`wallpaper_source.txt`**: Link to the wallpaper collection used.

## How to Restore

To restore these configurations on a new machine, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone git@github.com:LeulTew/leul-hyprland-config.git
   ```

2. **Copy configurations to `~/.config`:**

   ```bash
   cp -r leul-hyprland-config/config/* ~/.config/
   ```

3. **Restore shell configurations:**

   ```bash
   cp leul-hyprland-config/.zshrc ~/
   cp leul-hyprland-config/.bashrc ~/
   ```

4. **Re-download wallpapers:**
   Download from the source link in `wallpaper_source.txt` and place them in `~/Pictures/wallpapers`.

---

_Automatically generated backup by Antigravity IDE._
