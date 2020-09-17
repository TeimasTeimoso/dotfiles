# Tiling Window Manager files

## Installing bspwm
1. Install bspwm with _sudo apt install bspwm_ 
    + copy file to __.config/bspwm/__
2. Install sxhkd (keybindings) with _sudo apt install sxhkd_
    + copy file to __.config/sxhkd/__
3. Install Rofi with _sudo apt install bspwm_
    + copy rofi theme to __/usr/share/rofi/themes__ and config to __.config/rofi/__

## Installing polybar
1. Install dependencies with _sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2_
2. Clone repo _git clone https://github.com/jaagr/polybar.git_
3. Build _cd polybar && ./build.sh_
4. Copy config file to __.config/polybar/__

## Installing Picom (compositor)
1. _git clone https://github.com/yshui/picom && cd picom_
2. Install dependencies with _sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson_
3. _git submodule update --init --recursive_
4. Use meson build system to make ninja build _meson --buildtype=release . build_
5. Consume build file _ninja -C build_
6. Install build with _ninja -C build install_
7. copy _picom.conf_ from this repo to __.config/picom/__

## Installing i3lock FORK (screen-locker)
0. Install dependencies with _sudo apt install libxkbcommon-dev libxkbcommon-x11-dev_
1. _git clone https://github.com/Lixxia/i3lock && cd i3lock_
2. _autoreconf -fi_
3. _mkdir -p build && cd build_
4. _../configure_
5. _make && sudo make install_

## Fixing tap-to-click
Copy the following command:  
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/90-touchpad.conf 1> /dev/null
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection

EOF
