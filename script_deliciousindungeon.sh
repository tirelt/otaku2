#!/opt/homebrew/bin/bash

# Directory containing CBZ archives
input_dir="$HOME/Documents/DeliciousInDungeon/Delicious in Dungeon (2017-2024) (Digital) (1r0n)"
output_dir="$HOME/Documents/DeliciousInDungeon"
extract_dir="$HOME/Documents/DeliciousInDungeon/extract_folder"

# Ensure extract_dir exists
mkdir -p "$extract_dir"

# Loop through all CBZ files
echo "Scanning directory: $input_dir"

for file in "$input_dir"/Delicious\ in\ Dungeon\ v*; do
    # Extract volume number
    volume=$(echo "$file" | sed -E 's/.*Delicious in Dungeon v([0-9]+) .*/\1/')
    name="$output_dir/DeliciousInDungeon v$volume.pdf"
    
    # Check if the PDF already exists
    if [ -f "$name" ]; then
        echo "Volume $volume already processed. Skipping..."
        continue  # Skip to the next iteration
    fi
    
    echo "Processing Volume $volume..."

    # Unzip CBZ archive into the shared folder (overwrite previous files)
    rm -rf "${extract_dir:?}"/* # Clear previous images
    unzip -q "$file" -d "$extract_dir"

    # Convert the front page
    for pic in "$extract_dir"/*.jpg; do
        picname=$(echo "$pic" | sed -E 's/.*- p([0-9]{3}).*/\1/')
        magick "$pic" -colorspace Gray "$extract_dir/${picname}.png"
    done
    
    # Convert extracted images to PDF
    img2pdf "$extract_dir"/*.png -o "$name"
    qpdf --linearize --optimize-images --replace-input "$name"

    echo "Processed $name"
done

echo "All volumes have been converted!"