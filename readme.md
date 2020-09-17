# Tiling Window Manager files

## Installing bspwm

## Installing polybar


## Installing Picom (compositor)
1. _git clone https://github.com/yshui/picom && cd picom_
2. Install dependencies with _sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson_
3. _git submodule update --init --recursive_
4. Use meson build system to make ninja build _meson --buildtype=release . build_
5. Consume build file _ninja -C build_
6. Install build with _ninja -C build install_
7. copy _picom.conf_ from this repo to _.config/picom/_

## Installing i3lock FORK (screen-locker)
0. Install dependencies with _sudo apt install libxkbcommon-dev libxkbcommon-x11-dev_
1. _git clone https://github.com/Lixxia/i3lock && cd i3lock_
2. _autoreconf -fi_
3. _mkdir -p build && cd build_
4. _../configure_
5. _make && sudo make install_
