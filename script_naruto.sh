#!/bin/bash

# Set the target directory for all images
input_dir="$HOME/Documents/Naruto/Naruto"
output_dir="$HOME/Documents/Naruto"
extract_dir="$HOME/Documents/Naruto/extract_dir"

# Loop through all CBZ files
echo "Scanning directory: $input_dir"

merge_img(){
	 # Initialize counter for sequential naming
	 local counter=1

	 # Process folders in numerical order (1, 2, 3, ...)
	 for folder in $(find "$extract_dir" -maxdepth 1 -type d -name '[0-9]*' | sort -n); do
	 if [[ -d "$folder" ]]; then
		  # Process PNG files in each folder
		  for file in "$folder"/*.jpg; do
				if [[ -f "$file" ]]; then
                # Generate new filename with leading zeros (e.g., 01.png)
                new_name=$(printf "%02d.png" "$counter")
                # Move and rename file to output directory
                mv "$file" "$extract_dir/$new_name" && {
                    ((counter++))
                } 
				fi
        done
    else
        echo "Warning: $folder is not a directory, skipping"
    fi
done
}

for file in "$input_dir"/Naruto\ \(CM\)\ v01*; do
	# Extract volume number
	volume=$(echo "$file" | sed -E 's/.*v([0-9]+)\.cbz/\1/')
	name="$output_dir/Naruto v$volume.pdf"

	# Check if the PDF already exists
	if [ -f "$name" ]; then
		echo "Volume $volume already processed. Skipping..."
		continue  # Skip to the next iteration
	 fi
	echo "Processing Volume $volume..."

	# Unzip CBZ archive into the shared folder (overwrite previous files)
	rm -rf "$extract_dir"/*  # Clear previous images
	unzip -q "$file" -d "$extract_dir"

	merge_img
	   
    # Convert the front page
    for pic in "$extract_dir"/*.png; do
        picname=$(basename "$pic" .png)
        magick "$pic" -colorspace Gray "$pic"
	done

    #Convert extracted images to PDF
    img2pdf "$extract_dir"/*.png -o "$name"
    qpdf --linearize --optimize-images --replace-input "$name"

    echo "Processed $name"
done

echo "All volumes have been converted!"
