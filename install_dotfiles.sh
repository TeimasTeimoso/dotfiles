#!/bin/bash

USER_HOME=$(eval echo ~${SUDO_USER})
log_file="logs.txt"
package_list=(alacritty bspwm zsh sxhkd feh rofi)

touch $log_file

# INSTALLING MAIN PACKAGES

echo "Installing my dot files on Ubuntu"

for package in ${package_list[*]}
do
	# supress stdour and redirect stderr to file
	if apt install "$package" -y 1>/dev/null 2>$log_file; then
		echo ""$package" installed!"
	else
		echo ""$package" installation failed..."
		echo "Check logs.txt file."
		exit 1
	fi
done

# INSTALLING PICOM
echo "Installing Picom dependencies"
apt install cmake meson git pkg-config asciidoc libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev 1>/dev/null 2>$log_file
cd $USER_HOME/Downloads
git clone https://github.com/jonaburg/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
ninja -C build install

# INSTALLING POLYBAR
echo "Installing Polybar dependencies"
apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 python3-sphinx libjsoncpp-dev 1>/dev/null 2>$log_file
apt install libxcb-composite0-dev 1>/dev/null 2>$log_file
apt install libjsoncpp-dev 1>/dev/null 2>$log_file
ln -s /usr/include/jsoncpp/json/ /usr/include/json
cd $USER_HOME/Downloads
git clone https://github.com/jaagr/polybar.git
cd polybar && ./build.sh


# SWTICH TO USER HOME
cd $USER_HOME/

# copy herbstluftwm config
echo "Copying files"
#mkdir -p .config/herbstluftwm
#cp /etc/xdg/herbstluftwm/autostart .config/herbstluftwm/

# copy alacritty config

# install picom

# install polybar

# install rofi

# install spicetify

# install zsh