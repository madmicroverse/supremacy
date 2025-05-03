#!/bin/bash



# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 \"word1 word2 ...\""
  echo "Example: $0 \"sign in\""
  exit 1
fi

# Get the input string
input="$1"

# Convert to snake_case (lowercase with underscores)
snake_case=$(echo "$input" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Convert to camelCase (first word lowercase, subsequent words capitalized, no spaces)
camel_case=$(echo "$input" | awk '{
  result = tolower($1);
  for (i=2; i<=NF; i++) {
    word = $i;
    first_char = toupper(substr(word, 1, 1));
    rest = tolower(substr(word, 2));
    result = result first_char rest;
  }
  print result;
}')

# Convert to PascalCase (each word capitalized, no spaces)
pascal_case=$(echo "$input" | awk '{
  result = "";
  for (i=1; i<=NF; i++) {
    word = $i;
    first_char = toupper(substr(word, 1, 1));
    rest = tolower(substr(word, 2));
    result = result first_char rest;
  }
  print result;
}')


echo "Creating new feature:"
echo "- Feature file name: $snake_case"
echo "- Camel case name: $snake_case"
echo "- Feature name: $feature_name"

# Create target directory if it doesn't exist
mkdir -p lib/fragments/$snake_case

# Copy template directory to fragments directory, excluding .freezed.dart and .g.dart files
echo "Copying template files..."
rsync -av --exclude="*.freezed.dart" --exclude="*.g.dart" lib/templates/feature/ lib/fragments/$snake_case/

# Process all files in the new feature directory
echo "Processing files..."
find lib/fragments/$snake_case -type f | while read file; do
    # Replace content in files
    sed -i '' "s/tmpl_/$snake_case\_/g" "$file"
    sed -i '' "s/tmpl/$snake_case/g" "$file"
    sed -i '' "s/Tmpl/$pascal_case/g" "$file"
    
    # Rename files if they contain 'tmpl'
    if [[ $(basename "$file") == *"tmpl"* ]]; then
        new_name=$(echo "$file" | sed "s/tmpl/$snake_case/g")
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done

echo "Feature creation complete!"

# Run setup script
echo "Running setup.sh..."
./setup.sh

echo "All done!"
