#!/usr/bin/env python3
import os
import shutil
import datetime
import time
import argparse
from pathlib import Path

def parse_datetime(datetime_str):
    """Parse datetime string in format 'yyyy-MM-dd HH:mm'"""
    try:
        return datetime.datetime.strptime(datetime_str, "%Y-%m-%d %H:%M")
    except ValueError:
        raise argparse.ArgumentTypeError(f"Invalid datetime format: {datetime_str}. Expected format: yyyy-MM-dd HH:mm")

def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Copy Voice Memos created after a specified cutoff time")
    parser.add_argument("--cutoff", type=parse_datetime, 
                        help="Cutoff time in format 'yyyy-MM-dd HH:mm' (local time)")
    args = parser.parse_args()
    
    # Source directory with Voice Memos
    source_dir = os.path.expanduser("~/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings")
    
    # Target directory - relative to script location
    script_dir = os.path.dirname(os.path.abspath(__file__))
    target_dir = os.path.join(script_dir, "new_memories")
    
    # Create target directory if it doesn't exist
    if not os.path.exists(target_dir):
        print(f"Creating directory: {target_dir}")
        os.makedirs(target_dir)
    
    # Get current date and time
    now = datetime.datetime.now()
    
    # Set cutoff time based on command line argument or default to today at 10 PM
    if args.cutoff:
        cutoff_time = args.cutoff
        print(f"Using provided cutoff time: {cutoff_time}")
    else:
        cutoff_time = now.replace(hour=22, minute=0, second=0, microsecond=0)
        print(f"Using default cutoff time: {cutoff_time}")
    
    # Find and copy files
    copied_count = 0
    skipped_count = 0
    
    print(f"Searching for .m4a files in {source_dir}")
    print(f"Files modified after {cutoff_time} will be copied")
    
    # Check if source directory exists
    if not os.path.exists(source_dir):
        print(f"Error: Source directory {source_dir} does not exist")
        return
    
    for file in os.listdir(source_dir):
        if file.lower().endswith('.m4a'):
            source_path = os.path.join(source_dir, file)
            target_path = os.path.join(target_dir, file)
            
            # Get file modification time
            mod_time = datetime.datetime.fromtimestamp(os.path.getmtime(source_path))
            
            # Check if file already exists in target directory
            if os.path.exists(target_path):
                print(f"Skipping: {file} - Already exists in target directory")
                skipped_count += 1
                continue
            
            # Check if file was modified after today at 10 PM
            if mod_time > cutoff_time:
                print(f"Copying: {file} (Modified: {mod_time})")
                shutil.copy2(source_path, target_path)
                
                # Check for composition manifest file
                file_name_without_ext = os.path.splitext(file)[0]
                composition_dir = os.path.join(source_dir, f"{file_name_without_ext}.composition")
                manifest_path = os.path.join(composition_dir, "manifest.plist")
                
                if os.path.exists(manifest_path):
                    # Create target composition directory
                    target_composition_dir = os.path.join(target_dir, f"{file_name_without_ext}.composition")
                    if not os.path.exists(target_composition_dir):
                        os.makedirs(target_composition_dir)
                    
                    # Copy manifest file
                    target_manifest_path = os.path.join(target_composition_dir, "manifest.plist")
                    print(f"Copying composition manifest for: {file}")
                    shutil.copy2(manifest_path, target_manifest_path)
                
                copied_count += 1
            else:
                print(f"Skipping: {file} - Modified before cutoff time (Modified: {mod_time})")
                skipped_count += 1
    
    print(f"\nSummary:")
    print(f"Files copied: {copied_count}")
    print(f"Files skipped: {skipped_count}")

if __name__ == "__main__":
    main()
