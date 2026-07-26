# Table of Contents

<!-- vim-markdown-toc GFM -->

* [Launch KDE/Qt applications with Breeze, Fusion, or Kvantum on Omarchy](#launch-kdeqt-applications-with-breeze-fusion-or-kvantum-on-omarchy)
    * [Purpose](#purpose)
    * [Available styles](#available-styles)
    * [Generic command for any KDE/Qt application](#generic-command-for-any-kdeqt-application)
    * [LabPlot with Breeze](#labplot-with-breeze)
    * [LabPlot with Fusion](#labplot-with-fusion)
    * [LabPlot with Kvantum](#labplot-with-kvantum)
    * [Drawy with Breeze](#drawy-with-breeze)
    * [Quickly change an existing override](#quickly-change-an-existing-override)
    * [Revert an application to the default Omarchy style](#revert-an-application-to-the-default-omarchy-style)
    * [Useful package names](#useful-package-names)
    * [Recommended setup](#recommended-setup)
* [Fix application scaling on HiDPI displays](#fix-application-scaling-on-hidpi-displays)
    * [Context](#context)
    * [Test scaling before making it permanent](#test-scaling-before-making-it-permanent)
    * [Generic command: set style and scaling for any KDE/Qt app](#generic-command-set-style-and-scaling-for-any-kdeqt-app)
    * [LabPlot with Breeze and 2x scaling](#labplot-with-breeze-and-2x-scaling)
    * [LabPlot with Fusion and 2x scaling](#labplot-with-fusion-and-2x-scaling)
    * [Quickly change the scale of an existing override](#quickly-change-the-scale-of-an-existing-override)
    * [Add scaling to an existing style override](#add-scaling-to-an-existing-style-override)
    * [Remove scaling but keep the style override](#remove-scaling-but-keep-the-style-override)
    * [Recommended scale values](#recommended-scale-values)
    * [Revert the application to the default Omarchy behavior](#revert-the-application-to-the-default-omarchy-behavior)

<!-- vim-markdown-toc -->


# Launch KDE/Qt applications with Breeze, Fusion, or Kvantum on Omarchy

## Purpose

Omarchy may launch Qt/KDE applications globally with Kvantum using:

```bash
QT_STYLE_OVERRIDE=kvantum
```

This is usually fine, but some applications may look or behave better with another Qt style, such as:

```bash
Breeze
Fusion
kvantum
```

The safest solution is to override the Qt style **per application** by modifying the local `.desktop` launcher under:

```bash
~/.local/share/applications/
```

This does not change the global Omarchy theme.

---

## Available styles

Use one of these values:

```bash
Breeze
Fusion
kvantum
```

Recommended usage:

| Style     | Use when                           |
| --------- | ---------------------------------- |
| `Breeze`  | You want a KDE-native look         |
| `Fusion`  | You want maximum compatibility     |
| `kvantum` | You want Omarchy’s default Qt look |

---

## Generic command for any KDE/Qt application

Change only these two variables:

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"
```

Then run:

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

---

## LabPlot with Breeze

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze labplot2 %U
```

---

## LabPlot with Fusion

```bash
APP_PKG="labplot"
QT_STYLE="Fusion"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Fusion labplot2 %U
```

---

## LabPlot with Kvantum

```bash
APP_PKG="labplot"
QT_STYLE="kvantum"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=kvantum labplot2 %U
```

---

## Drawy with Breeze

```bash
APP_PKG="drawy"
QT_STYLE="Breeze"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze drawy
```

---

## Quickly change an existing override

Use this when the local launcher already exists and already contains `QT_STYLE_OVERRIDE=...`.

Example: change Drawy to Breeze:

```bash
APP_PKG="drawy"
QT_STYLE="Breeze"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/QT_STYLE_OVERRIDE=(Breeze|Fusion|kvantum)/QT_STYLE_OVERRIDE=$QT_STYLE/g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Example: change LabPlot to Fusion:

```bash
APP_PKG="labplot"
QT_STYLE="Fusion"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/QT_STYLE_OVERRIDE=(Breeze|Fusion|kvantum)/QT_STYLE_OVERRIDE=$QT_STYLE/g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

---

## Revert an application to the default Omarchy style

To remove the local override and return the application to the system launcher:

```bash
APP_PKG="labplot"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

rm -f "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

After this, the application will inherit the global Omarchy Qt style again, usually Kvantum.

---

## Useful package names

Examples:

```bash
APP_PKG="drawy"
APP_PKG="labplot"
APP_PKG="okular"
APP_PKG="kate"
APP_PKG="gwenview"
APP_PKG="ark"
```

The value of `APP_PKG` is the Arch package name, not necessarily the executable name.

For example:

```bash
APP_PKG="labplot"
```

may launch:

```bash
labplot2
```

The command handles this automatically because it reads the existing `.desktop` file.

---

## Recommended setup

A clean Omarchy setup can be:

```text
Global Qt style: Kvantum
Specific KDE/Qt app override: Breeze or Fusion
```

Use:

```bash
QT_STYLE_OVERRIDE=Breeze
```

for a KDE-native appearance.

Use:

```bash
QT_STYLE_OVERRIDE=Fusion
```

for maximum compatibility.

Use:

```bash
QT_STYLE_OVERRIDE=kvantum
```

to match Omarchy’s default Qt styling.


# Fix application scaling on HiDPI displays

## Context

Some Qt/KDE applications may appear too small on HiDPI displays.

For example, on a laptop with:

```text
Resolution: 2880x1800
Scale: 2x
Screen size: 14"
```

an application such as LabPlot may open with text, icons, menus, and interface elements that are too small.

This can be fixed per application by adding a Qt scale factor to the local `.desktop` launcher.

The most useful variable is:

```bash
QT_SCALE_FACTOR=2
```

For a 2x display, start with:

```bash
QT_SCALE_FACTOR=2
```

If the interface becomes too large, try:

```bash
QT_SCALE_FACTOR=1.5
```

or:

```bash
QT_SCALE_FACTOR=1.75
```

---

## Test scaling before making it permanent

Example: test LabPlot with Breeze and 2x scaling:

```bash
env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze QT_SCALE_FACTOR=2 labplot
```

Example: test LabPlot with Fusion and 2x scaling:

```bash
env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Fusion QT_SCALE_FACTOR=2 labplot
```

Example: test LabPlot with Kvantum and 2x scaling:

```bash
env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=kvantum QT_SCALE_FACTOR=2 labplot
```

If the application looks too large, test a smaller factor:

```bash
env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze QT_SCALE_FACTOR=1.5 labplot
```

or:

```bash
env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze QT_SCALE_FACTOR=1.75 labplot
```

---

## Generic command: set style and scaling for any KDE/Qt app

Change only these variables:

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"
QT_SCALE="2"
```

Then run:

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"
QT_SCALE="2"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORM=\S+\s*//g;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $cmd =~ s/\bQT_SCALE_FACTOR=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORM=wayland\\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' QT_SCALE_FACTOR='"$QT_SCALE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

This command does the following automatically:

1. Finds the application’s `.desktop` launcher.
2. Copies it to `~/.local/share/applications/`.
3. Rewrites the `Exec=` line.
4. Adds the selected Qt style.
5. Adds the selected Qt scale factor.
6. Refreshes the local desktop launcher database.

---

## LabPlot with Breeze and 2x scaling

```bash
APP_PKG="labplot"
QT_STYLE="Breeze"
QT_SCALE="2"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORM=\S+\s*//g;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $cmd =~ s/\bQT_SCALE_FACTOR=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORM=wayland\\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' QT_SCALE_FACTOR='"$QT_SCALE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze QT_SCALE_FACTOR=2 labplot2 %U
```

Then open LabPlot from Walker.

If Walker still opens the old launcher, log out and log back in.

---

## LabPlot with Fusion and 2x scaling

```bash
APP_PKG="labplot"
QT_STYLE="Fusion"
QT_SCALE="2"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

mkdir -p ~/.local/share/applications

cp "$desktop_file" "$local_file"

perl -i -pe '
if (/^Exec=(.*)$/) {
    $cmd = $1;
    $cmd =~ s/^env\s+//;
    $cmd =~ s/\bQT_QPA_PLATFORM=\S+\s*//g;
    $cmd =~ s/\bQT_QPA_PLATFORMTHEME=\S+\s*//g;
    $cmd =~ s/\bQT_STYLE_OVERRIDE=\S+\s*//g;
    $cmd =~ s/\bQT_SCALE_FACTOR=\S+\s*//g;
    $_ = "Exec=env QT_QPA_PLATFORM=wayland\\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE='"$QT_STYLE"' QT_SCALE_FACTOR='"$QT_SCALE"' $cmd\n";
}
' "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORM=wayland\;xcb QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Fusion QT_SCALE_FACTOR=2 labplot2 %U
```

---

## Quickly change the scale of an existing override

Use this when the local launcher already exists and already contains `QT_SCALE_FACTOR=...`.

Example: change LabPlot to 1.75x scaling:

```bash
APP_PKG="labplot"
QT_SCALE="1.75"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/QT_SCALE_FACTOR=[^ ]+/QT_SCALE_FACTOR=$QT_SCALE/g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Example: change LabPlot to 2x scaling:

```bash
APP_PKG="labplot"
QT_SCALE="2"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/QT_SCALE_FACTOR=[^ ]+/QT_SCALE_FACTOR=$QT_SCALE/g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

---

## Add scaling to an existing style override

Use this if the local launcher already has `QT_STYLE_OVERRIDE=...`, but does not yet have `QT_SCALE_FACTOR=...`.

Example: add 2x scaling to LabPlot:

```bash
APP_PKG="labplot"
QT_SCALE="2"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/(QT_STYLE_OVERRIDE=[^ ]+)/\1 QT_SCALE_FACTOR=$QT_SCALE/g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

Expected result:

```ini
Exec=env QT_QPA_PLATFORMTHEME=qt6ct QT_STYLE_OVERRIDE=Breeze QT_SCALE_FACTOR=2 labplot2 %U
```

---

## Remove scaling but keep the style override

Use this if the application becomes too large and you want to remove only the scale override.

Example: remove scaling from LabPlot:

```bash
APP_PKG="labplot"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

sed -i -E "s/ ?QT_SCALE_FACTOR=[^ ]+//g" "$local_file"

grep '^Exec=' "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

---

## Recommended scale values

For a 14-inch 2880x1800 display with 2x desktop scaling, try these values in order:

```text
QT_SCALE_FACTOR=2
QT_SCALE_FACTOR=1.75
QT_SCALE_FACTOR=1.5
```

Recommended LabPlot setup for this laptop:

```text
Qt style: Breeze
Qt scale factor: 2
```

That corresponds to:

```bash
QT_STYLE_OVERRIDE=Breeze
QT_SCALE_FACTOR=2
```

If LabPlot becomes too large, use:

```bash
QT_SCALE_FACTOR=1.75
```

or:

```bash
QT_SCALE_FACTOR=1.5
```

---

## Revert the application to the default Omarchy behavior

To remove the local override completely:

```bash
APP_PKG="labplot"

desktop_file="$(pacman -Ql "$APP_PKG" | awk '/\/applications\/.*\.desktop$/ {print $2; exit}')"
local_file="$HOME/.local/share/applications/$(basename "$desktop_file")"

rm -f "$local_file"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

After this, the application will inherit the global Omarchy Qt style and scaling behavior again.
