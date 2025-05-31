#!/bin/sh
# Install essential packages for a my OpenSUSE setup

set -e

########################### Variables ##########################

ESSENTIALS=(
    git
    curl
    wget
    htop
    neofetch
    opi
    kitty
    hyprland
    hyprland-devel
    rofi
    flatpak
)

DEVELOPMENT_TOOLS=(
    gcc
    code
    docker
    docker-compose
    go
)

declare -A FLATPAK_REPOS=(
    ["Spotify"]="com.spotify.Client"
    ["Bitwarden"]="com.bitwarden.desktop"

)

########################## Functions ##########################

check_installed() {
    echo "🔍 Verifying installed packages:"
    local type="$1"
    shift
    local pkgs=("$@")
    for pkg in "${pkgs[@]}"; do
        if [ "$type" = "rpm" ]; then
            if rpm -q "$pkg" &>/dev/null; then
                echo "✅ $pkg is installed"
            else
                echo "❌ $pkg is NOT installed"
            fi
        elif [ "$type" = "flatpak" ]; then
            if flatpak list --app | grep -qw "$pkg"; then
                echo "✅ $pkg is installed"
            else
                echo "❌ $pkg is NOT installed"
            fi
        else
            echo "Unknown package type: $type"
            return 1
        fi
    done
}

########################## main ################################

# Setting up VSCode repo
echo "Adding Visual Studio Code Repo..."
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper refresh

# Installing packages
echo "Installing essential packages..."
zypper in -y "${ESSENTIALS[@]}"
check_installed rpm "${ESSENTIALS[@]}"

echo "Installing development tools..."
zypper in -y "${DEVELOPMENT_TOOLS[@]}"
check_installed rpm "${DEVELOPMENT_TOOLS[@]}"

# Adding Flatpak repos and installing Flatpak apps
echo "Setting up Flatpak repositories and installing applications..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
for repo in "${!FLATPAK_REPOS[@]}"; do
    echo "Adding Flatpak repository for $repo..."
    flatpak install -y flathub "${FLATPAK_REPOS[$repo]}"
done
check_installed flatpak "${FLATPAK_REPOS[@]}"


