# Dotfiles

Last tested on Ubuntu 21.04

## Alacritty
_sudo apt install alacritty_

## bspwm
_sudo apt install bspwm sxhkd feh_

## Polybar
### Install dependencies
1. _sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 python3-sphinx libjsoncpp-dev_
2. _sudo apt install libxcb-composite0-dev_
3. _sudo apt install libjsoncpp-dev_
4. _sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json_

### Install Polybar
1. _git clone https://github.com/jaagr/polybar.git_
2. _cd polybar && ./build.sh_

## rofi
- _sudo apt install rofi_
