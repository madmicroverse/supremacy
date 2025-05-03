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
echo "snake_case: $snake_case"

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
echo "camelCase: $camel_case"

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
echo "PascalCase: $pascal_case"
