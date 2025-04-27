#!/bin/bash

# Directory containing CBZ archives
input_dir="$HOME/Documents/OnePiece/One Piece (Digital) (1r0n)"
output_dir="$HOME/Documents/OnePiece"
extract_dir="$HOME/Documents/OnePiece/extract_folder"

# Loop through all CBZ files
echo "Scanning directory: $input_dir"

for file in "$input_dir"/One\ Piece\ v*; do
    # Extract volume number
    volume=$(echo "$file" | sed -E 's/.*One Piece v([0-9]+) .*/\1/')

    # Unzip CBZ archive into the shared folder (overwrite previous files)
    rm -rf "$extract_dir"/*  # Clear previous images
    unzip -q "$file" -d "$extract_dir"

    # Convert extracted images to PDF
    img2pdf "$extract_dir"/*.png "$extract_dir"/*.jpg -o "$output_dir/OnePiece v$volume.pdf"

    echo "Processed Volume $volume: OnePiece - $volume.pdf"
done

echo "All volumes have been converted!"