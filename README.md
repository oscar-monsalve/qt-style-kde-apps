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
