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
    name="$output_dir/OnePiece v$volume.pdf"
    
    # Check if the PDF already exists
    if [ -f "$name" ]; then
        echo "Volume $volume already processed. Skipping..."
        continue  # Skip to the next iteration
    fi
    
    echo "Processing Volume $volume..."

    # Unzip CBZ archive into the shared folder (overwrite previous files)
    rm -rf "$extract_dir"/*  # Clear previous images
    unzip -q "$file" -d "$extract_dir"

    # Convert the front page
    for pic in "$extract_dir"/*.jpg; do
        picname=$(basename "$pic" .jpg)
        magick "$pic" -colorspace Gray "$extract_dir/${picname}.png"
    done
    
    # Convert extracted images to PDF
    img2pdf "$extract_dir"/*.png -o "$name"
    qpdf --linearize --optimize-images --replace-input "$name"

    echo "Processed $name"
done

echo "All volumes have been converted!"