#!/bin/bash

CONFIGS_DIR="$1"
if [ -z "$CONFIGS_DIR" ]; then
    echo "Usage: $0 <configs_dir>"
    exit 1
fi

TARGET_DIR="$HOME/.config"

mkdir -p "$TARGET_DIR"

echo "Copying configuration folders from $CONFIGS_DIR to $TARGET_DIR"
for folder in "$CONFIGS_DIR"/*; do
    if [ -d "$folder" ]; then
        folder_name=$(basename "$folder")
        target_folder="$TARGET_DIR/$folder_name"
        if [ -d "$target_folder" ]; then
            echo "Replacing existing folder: $target_folder"
            rm -rf "$target_folder"
        fi
        cp -r "$folder" "$target_folder"
        echo "Copied $folder_name"
    fi
done

if [ -f "$CONFIGS_DIR/zshrc" ]; then
    echo "Copying content of zshrc to ~/.zshrc"
    cat "$CONFIGS_DIR/zshrc" > "$HOME/.zshrc"
    echo "Done appending zshrc"
fi