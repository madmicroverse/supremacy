#!/usr/bin/env python3
import speech_recognition as sr
import os
import json
import datetime
import logging
from pydub import AudioSegment
import tempfile
import sys
import plistlib
import re

# Get the directory where this script is located
script_dir = os.path.dirname(os.path.abspath(__file__))

# Set up logging
logging.basicConfig(
    filename=os.path.join(script_dir, 'transcription_errors.log'),
    level=logging.ERROR,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def transcribe_audio(audio_file_path, output_text_file=None, output_json_file=None):
    """
    Transcribe an audio file to text and optionally save to text and JSON files
    Only creates files if transcription is successful
    """
    print(f"Processing: {os.path.basename(audio_file_path)}")
    
    try:
        # Get file metadata
        file_stats = os.stat(audio_file_path)
        modified_time = datetime.datetime.fromtimestamp(file_stats.st_mtime)
        created_time = datetime.datetime.fromtimestamp(file_stats.st_ctime)
        file_size = file_stats.st_size
        
        # Convert .m4a to .wav using pydub
        audio = AudioSegment.from_file(audio_file_path, format="m4a")
        audio_duration = len(audio) / 1000.0  # Duration in seconds
        
        # Use a temporary file for the .wav conversion
        with tempfile.NamedTemporaryFile(suffix='.wav', delete=False) as temp_wav:
            temp_wav_name = temp_wav.name
            audio.export(temp_wav_name, format="wav")
        
        # Initialize recognizer
        recognizer = sr.Recognizer()
        
        # Load the audio file
        with sr.AudioFile(temp_wav_name) as source:
            print(f"  Reading audio data...")
            audio_data = recognizer.record(source)
        
        # Delete the temporary file
        os.unlink(temp_wav_name)
        
        try:
            # Use Google's speech recognition
            print(f"  Transcribing...")
            text = recognizer.recognize_google(audio_data)
            
            # Create metadata dictionary
            metadata = {
                "filename": os.path.basename(audio_file_path),
                "transcript": text,
                "modified_date": modified_time.strftime("%Y-%m-%d"),
                "modified_time": modified_time.strftime("%H:%M:%S"),
                "created_date": created_time.strftime("%Y-%m-%d"),
                "created_time": created_time.strftime("%H:%M:%S"),
                "file_size_bytes": file_size,
                "audio_duration_seconds": audio_duration,
                "transcription_date": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            }
            
            # Save to text file if specified
            # if output_text_file:
            #     with open(output_text_file, 'w') as f:
            #         f.write(text)
            #     print(f"  Transcription saved to {os.path.basename(output_text_file)}")
            
            # Save to JSON file if specified
            if output_json_file:
                with open(output_json_file, 'w') as f:
                    json.dump(metadata, f, indent=2)
                print(f"  Metadata saved to {os.path.basename(output_json_file)}")
            
            return True, text, metadata
            
        except sr.UnknownValueError:
            message = f"Speech Recognition could not understand audio: {os.path.basename(audio_file_path)}"
            print(f"  {message}")
            logging.error(message)
            
            # Don't create any files for failed transcriptions
            return False, message, None
            
        except sr.RequestError as e:
            message = f"Could not request results from Speech Recognition service for {os.path.basename(audio_file_path)}; {e}"
            print(f"  {message}")
            logging.error(message)
            
            # Don't create any files for failed transcriptions
            return False, message, None
            
    except Exception as e:
        message = f"Error processing file {os.path.basename(audio_file_path)}: {e}"
        print(f"  {message}")
        logging.error(message)
        
        # Don't create any files for failed transcriptions
        return False, message, None

def get_target_directory_from_manifest(audio_file_path):
    """
    Extract the target directory from the manifest.plist file associated with the audio file.
    Returns the target directory path or None if not found or invalid.
    """
    try:
        # Get the base name of the audio file without extension
        base_name = os.path.splitext(os.path.basename(audio_file_path))[0]
        
        # Construct the path to the composition directory and manifest file
        composition_dir = os.path.join(os.path.dirname(audio_file_path), f"{base_name}.composition")
        manifest_path = os.path.join(composition_dir, "manifest.plist")
        
        # Check if manifest file exists
        if not os.path.exists(manifest_path):
            print(f"  No manifest file found for {base_name}")
            return None
        
        # Read the manifest.plist file
        with open(manifest_path, 'rb') as f:
            manifest_data = plistlib.load(f)
        
        # Extract the RCSavedRecordingTitle
        if 'RCSavedRecordingTitle' in manifest_data:
            title = manifest_data['RCSavedRecordingTitle']
            
            # The first part of the string before '/' is the target directory
            parts = title.split('/', 1)
            if len(parts) > 1:
                target_dir = parts[0]
                return target_dir
            else:
                print(f"  Invalid RCSavedRecordingTitle format: {title}")
                return None
        else:
            print(f"  No RCSavedRecordingTitle found in manifest for {base_name}")
            return None
            
    except Exception as e:
        print(f"  Error reading manifest for {os.path.basename(audio_file_path)}: {e}")
        logging.error(f"Error reading manifest for {os.path.basename(audio_file_path)}: {e}")
        return None

def is_already_transcribed(base_name, collected_transcripts):
    """
    Check if a file has already been transcribed by looking at the collected_transcripts.json
    """
    for entry in collected_transcripts:
        # Extract the base name from the file_path in collected_transcripts
        file_path = entry.get("file_path", "")
        entry_base_name = os.path.splitext(os.path.basename(file_path))[0]
        
        # Debug output to help diagnose the issue
        print(f"  Comparing: '{entry_base_name}' with '{base_name}'")
        
        if entry_base_name == base_name:
            print(f"  Match found! '{base_name}' is already transcribed")
            return True
    
    print(f"  No match found for '{base_name}' in collected_transcripts")
    return False

def main():
    # Source directory with .m4a files - relative to script location
    source_dir = os.path.join(script_dir, "new_memories")
    
    # Base output directory for transcripts and metadata - relative to script location
    base_output_dir = os.path.join(script_dir, "new_memories_transcripts")
    
    # Path to collected transcripts file
    collected_transcripts_path = os.path.join(script_dir, "collected_transcripts.json")
    
    # Load collected transcripts if the file exists
    collected_transcripts = []
    if os.path.exists(collected_transcripts_path):
        try:
            with open(collected_transcripts_path, 'r') as f:
                collected_transcripts = json.load(f)
            print(f"Loaded {len(collected_transcripts)} existing transcriptions from collected_transcripts.json")
        except Exception as e:
            print(f"Error loading collected_transcripts.json: {e}")
            logging.error(f"Error loading collected_transcripts.json: {e}")
    
    # Create base output directory if it doesn't exist
    if not os.path.exists(base_output_dir):
        print(f"Creating directory: {base_output_dir}")
        os.makedirs(base_output_dir)
    
    # Process all .m4a files
    files_processed = 0
    files_failed = 0
    files_skipped = 0
    
    print(f"Searching for .m4a files in {source_dir}")
    
    # Check if source directory exists
    if not os.path.exists(source_dir):
        print(f"Error: Source directory {source_dir} does not exist")
        logging.error(f"Source directory {source_dir} does not exist")
        return
    
    for file in os.listdir(source_dir):
        if file.lower().endswith('.m4a'):
            audio_path = os.path.join(source_dir, file)
            base_name = file.replace('.m4a', '')
            
            # Check if this file has already been transcribed
            if is_already_transcribed(base_name, collected_transcripts):
                print(f"Skipping {file} - Already in collected_transcripts.json")
                files_skipped += 1
                continue
            
            # Get target directory from manifest.plist
            target_dir = get_target_directory_from_manifest(audio_path)
            
            if target_dir:
                # Create target directory path
                output_dir = os.path.join(base_output_dir, target_dir)
                if not os.path.exists(output_dir):
                    print(f"Creating directory: {output_dir}")
                    os.makedirs(output_dir)
            else:
                # Use default output directory if no target directory found
                output_dir = base_output_dir
                print(f"Using default output directory for {file}")
            
            text_path = os.path.join(output_dir, f"{base_name}.txt")
            json_path = os.path.join(output_dir, f"{base_name}.json")
            
            # Skip if both transcript and JSON already exist locally
            if os.path.exists(text_path) and os.path.exists(json_path):
                print(f"Skipping {file} - Transcript and metadata files already exist locally")
                files_skipped += 1
                continue
            
            success, result, metadata = transcribe_audio(audio_path, text_path, json_path)
            
            if success:
                files_processed += 1
            else:
                files_failed += 1
    
    print(f"\nSummary:")
    print(f"Files successfully transcribed: {files_processed}")
    print(f"Files failed: {files_failed}")
    print(f"Files skipped: {files_skipped}")
    if files_failed > 0:
        print(f"Check transcription_errors.log for details on failed transcriptions")

if __name__ == "__main__":
    main()
