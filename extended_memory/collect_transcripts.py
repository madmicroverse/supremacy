#!/usr/bin/env python3
import os
import json
import glob
import hashlib
import uuid
from datetime import datetime

# Directory containing the JSON files
base_dir = "/Users/roldan/supremacy/extended_memory/new_memories_transcripts"

# Output file path
output_file = "/Users/roldan/supremacy/extended_memory/collected_transcripts.json"

# Load existing data if available
existing_data = []
existing_file_paths = set()
if os.path.exists(output_file):
    try:
        with open(output_file, 'r') as f:
            existing_data = json.load(f)
            # Create a set of existing file paths for quick lookup
            existing_file_paths = {item["file_path"] for item in existing_data}
    except Exception as e:
        print(f"Error loading existing data: {e}")

# Find all JSON files recursively
json_files = glob.glob(f"{base_dir}/**/*.json", recursive=True)

# Counter for new entries
new_entries = 0

# Process each JSON file
for file_path in json_files:
    try:
        # Make the file path relative to the extended_memory directory
        relative_path = os.path.relpath(file_path, "/Users/roldan/supremacy/extended_memory")
        
        # Skip if this file is already in our collection
        if relative_path in existing_file_paths:
            print(f"Skipping (already exists): {relative_path}")
            continue
        
        # Get file stats
        file_stats = os.stat(file_path)
        modified_time = datetime.fromtimestamp(file_stats.st_mtime)
        
        # Read and parse the JSON file
        with open(file_path, 'r') as f:
            data = json.load(f)
        
        # Extract the filename to use as a unique identifier
        filename = os.path.basename(file_path)
        
        # Extract the required information
        transcript_data = {
            "id": filename,  # Using filename as unique identifier
            "file_path": relative_path,
            "transcript": data.get("transcript", ""),
            "modified_date": modified_time.strftime("%Y-%m-%d"),
            "modified_time": modified_time.strftime("%H:%M:%S"),
            "is_completed": False  # Adding default is_completed property
        }
        
        # Add to our collection
        existing_data.append(transcript_data)
        existing_file_paths.add(relative_path)
        new_entries += 1
        print(f"Added new entry: {relative_path}")
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

# Write the collected data to the output file
with open(output_file, 'w') as f:
    json.dump(existing_data, f, indent=2, sort_keys=True, ensure_ascii=False)

print(f"\nCollection complete. Data saved to {os.path.basename(output_file)}")
print(f"Total entries: {len(existing_data)} ({new_entries} new)")
