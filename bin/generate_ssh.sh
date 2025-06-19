#!/bin/sh

# Author: Ruben Teimas (@TeimasTeimoso)

# Generate a new SSH key for GitHub
# Args: [<email>] [<key_name>]
set -e

if [ -z "$1"]; then
    EMAIL="your_email@example.com"
else
    EMAIL="$1"
fi

if [ -z "$2" ]; then
    KEY_NAME="id_ed25519"
else
    KEY_NAME="$2"
fi

ssh-keygen -t ed25519 -C "$EMAIL" -N "" -f ~/.ssh/"$KEY_NAME"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/"$KEY_NAME"

echo "SSH key generated at ~/.ssh/$KEY_NAME and added to the agent."