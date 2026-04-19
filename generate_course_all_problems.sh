#!/bin/bash

# Define the output file name
output_file="topiclists/default/all_problems.txt"

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$output_file")"

# Clear the output file and prepend the header
echo "Chapter: All problems." > "$output_file"
echo "" >> "$output_file"

# Find all .html files in the specific directory
find ./problems/default/ -type f -name "*.html" | while read -r file; do
    
    # Remove leading ./ (Result: problems/default/sub/file.html)
    clean_path="${file#./}"
    
    # Remove "default/" from the path (Result: problems/sub/file.html)
    formatted_path="${clean_path/default\//}"
    
    # Get just the filename for the Title
    filename="${clean_path##*/}"
    
    # Check to ensure we don't accidentally process the output file
    if [[ "$clean_path" != "$output_file" ]]; then
        {
            echo "Title: $filename"
            echo "Problem: $formatted_path"
            echo ""
        } >> "$output_file"
    fi
done

echo "Successfully generated $output_file"
