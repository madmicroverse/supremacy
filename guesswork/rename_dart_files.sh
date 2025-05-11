#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <search_string> <replace_string>"
    echo "Example: $0 selection selection"
    exit 1
fi

SEARCH_STRING="$1"
REPLACE_STRING="$2"

echo "Searching for Dart files and directories containing '$SEARCH_STRING' in their name and renaming with '$REPLACE_STRING'..."

# First, rename all Dart files containing the search string
echo "Processing files..."
find . -type f -name "*.dart" -name "*${SEARCH_STRING}*" | while read file; do
    # Get the directory and filename
    dir=$(dirname "$file")
    filename=$(basename "$file")
    
    # Create the new filename with the replacement
    new_filename="${filename//$SEARCH_STRING/$REPLACE_STRING}"
    
    # Only rename if the filename would actually change
    if [ "$filename" != "$new_filename" ]; then
        echo "Renaming file: $file -> $dir/$new_filename"
        mv "$file" "$dir/$new_filename"
    fi
done

# Then, rename directories containing the search string (process from deepest to shallowest)
echo "Processing directories..."
find . -type d -name "*${SEARCH_STRING}*" | sort -r | while read dir; do
    # Get the parent directory and directory name
    parent=$(dirname "$dir")
    dirname=$(basename "$dir")
    
    # Create the new directory name with the replacement
    new_dirname="${dirname//$SEARCH_STRING/$REPLACE_STRING}"
    
    # Only rename if the directory name would actually change
    if [ "$dirname" != "$new_dirname" ]; then
        echo "Renaming directory: $dir -> $parent/$new_dirname"
        mv "$dir" "$parent/$new_dirname"
    fi
done

echo "Renaming complete!"
