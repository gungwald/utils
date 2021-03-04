#!/bin/sh

# TODO - Put everything in ~/.local - No sudo required
# TODO - Auto download system hard disk

URL=http://apple2.gs/downloads/plusbuilds/0.14/gsplus-ubuntu-sdl.tar.bz2
ROM_URL=https://macgui.com/downloads/?mode=download&file_id=11145
DOWNLOADED_FILE="$HOME"/Downloads/gsplus.tar.bz2
DOWNLOADED_ROM=APPLE2GS.ROM2.gz
ICON_URL=http://apple2.gs/plus/img/gsp_icon_webhead_256.png
DOWNLOADED_ICON=gsplus.png
GIT_URL=https://github.com/digarok/gsplus
OS=$(uname -s)
CPU=$(uname -p)
INSTALLED_PROGRAM="$HOME"/.local/bin/gsplus
FIRMWARE_DIR="$HOME"/.local/share/firmware

if [ ! -f "$INSTALLED_PROGRAM" ]
then
    if [ "$OS" = Linux -a "$CPU" != x86_64 ]
    then
        # Need to build it
        # Pretty much only Debian supports non-x86_64 now.
        sudo apt install -y libpcap-dev libfreetype6-dev libsdl2-dev \
            libsdl2-image-dev re2c libreadline-dev cmake
        if [ ! -d "$HOME"/git/gsplus ]
        then
            (
            cd "$HOME"/git
            git clone "$GIT_URL"
            cd gsplus
            cat <<EOF > CMakeLists.txt
include_directories(include/SDL2)
include_directories(include/freetype2)
EOF
            )
        fi

        if [ -f build/bin/GSplus ]
        then
            (
            mkdir -p build
            cd build
            cmake ..
            make
            )
        fi
        install "$HOME"/git/gsplus/build/bin/GSplus \
            "$INSTALLED_PROGRAM"
    else
        if [ ! -f "$DOWNLOADED_FILE" ]
        then
            curl -o "$DOWNLOADED_FILE" "$URL"
        fi
        tar -xvjf "$DOWNLOADED_FILE" -C "$HOME"/Downloads
        install gsplus-ubuntu-sdl/gsplus "$INSTALLED_PROGRAM"
        rm -rf gsplus-ubuntu-sdl
    fi
fi

if [ ! -d "$FIRMWARE_DIR" ]
then
  if [ ! -f "$DOWNLOADED_ROM" ]
  then
    curl -o "$DOWNLOADED_ROM" "$ROM_URL"
  fi
  gunzip "$DOWNLOADED_ROM"
  mkdir -p "$FIRMWARE_DIR"
  install APPLE2GS.ROM2 "$FIRMWARE_DIR"
fi

mkdir -p "$HOME"/.local/share/gsplus

if [ ! -f "$HOME"/.local/share/icons/"$DOWNLOADED_ICON" ]
then
  curl -o "$HOME"/Downloads/"$DOWNLOADED_ICON" "$ICON_URL"
  install "$HOME"/Downloads/"$DOWNLOADED_ICON" "$HOME"/.local/share/icons
fi

cat <<EOF > ~/.local/share/applications/gsplus.desktop
[Desktop Entry]
Name=GS+
Exec=$INSTALLED_PROGRAM
Type=Application
StartupNotify=true
Terminal=false
Comment=Apple IIgs Emulator
Path=$HOME/.local/share/gsplus
Categories=Emulator
Encoding=UTF-8
Icon=$HOME/.local/share/icons/"$DOWNLOADED_ICON"
#
# See here for a list of valid categories:
# https://specifications.freedesktop.org/menu-spec/latest/apa.html
EOF
update-desktop-database ~/.local/share/applications/

if rpm --query SDL2_image
then
  SDL2_image already installed
else
  sudo dnf install -y SDL2_image
fi

cat <<EOF > "$HOME"/.local/share/gsplus/config.txt
# GSplus configuration file version 0.14

s5d1 =
s5d2 = 

s6d1 =
s6d2 = 

s7d1 = ../../../var/apple2gs/gsos-system-6.0.4.po
s7d2 =
s7d3 =
s7d4 =
s7d5 =
s7d6 =

g_invert_paddles = 1
g_cfg_rom_path = $FIRMWARE_DIR/APPLE2GS.ROM2
g_limit_speed = 3


bram1[00] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[10] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[20] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[30] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[40] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[50] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[60] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[70] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[80] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[90] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[a0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[b0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[c0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[d0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[e0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bram1[f0] = 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

bram3[00] = 00 00 00 01 00 00 0d 06 02 01 01 00 01 00 00 00
bram3[10] = 00 00 07 06 02 01 01 00 00 00 0f 06 06 00 05 06
bram3[20] = 01 00 00 00 00 00 00 01 00 00 00 00 05 02 02 00
bram3[30] = 00 00 2d 2d 00 00 00 00 00 00 02 02 02 06 08 00
bram3[40] = 01 02 03 04 05 06 07 0a 00 01 02 03 04 05 06 07
bram3[50] = 08 09 0a 0b 0c 0d 0e 0f 00 00 ff 12 ff ff ff 81
bram3[60] = ff ff 01 ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[70] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[80] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[90] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[a0] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[b0] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[c0] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[d0] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[e0] = ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
bram3[f0] = ff ff ff ff ff ff ff ff ff ff ff ff d9 27 73 8d
EOF


gsplus -config "$HOME"/.local/share/gsplus/config.txt

