#!/bin/bash

CONFIGS_DIR="$1"
if [ -z "$CONFIGS_DIR" ]; then
    echo "Usage: $0 <configs_dir>"
    exit 1
fi

TARGET_DIR="$HOME/.config"

mkdir -p "$TARGET_DIR"

for folder in "$CONFIGS_DIR"/*/; do
    folder_name=$(basename "$folder")
    target_folder="$TARGET_DIR/$folder_name"
    if [ -d "$target_folder" ]; then
        echo "Replacing existing folder: $target_folder"
        rm -rf "$target_folder"
    fi
    cp -r "$folder" "$target_folder"
    echo "Copied $folder_name to $TARGET_DIR"
done