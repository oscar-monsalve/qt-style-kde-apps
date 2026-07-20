#!/usr/bin/env bash

# Change only these two variables:
#
# ```bash
# APP_PKG="labplot"
# QT_STYLE="Breeze"
# ```

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
