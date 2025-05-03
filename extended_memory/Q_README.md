# Extended Memory: Voice-to-Text Note Taking System

## Overview
Extended Memory is a comprehensive voice-to-text note-taking system that transforms Apple Voice Memos into searchable, queryable text. The system automates the process of collecting voice recordings, transcribing them, and organizing the transcriptions for easy reference and task management.

## System Components

### 1. Voice Memo Collection (`copy_voice_memos.py`)
- **Purpose**: Copies new voice memo recordings from Apple's Voice Memos app to the project directory
- **Features**:
  - Identifies voice memos created after a specified cutoff time
  - Preserves file metadata and associated composition files
  - Supports custom cutoff time via command-line arguments
  - Creates a `new_memories` directory to store copied voice memos
- **Usage**: `python copy_voice_memos.py --cutoff "YYYY-MM-DD HH:MM"`

### 2. Audio Transcription (`transcribe_audio.py`)
- **Purpose**: Converts voice recordings to text using speech recognition
- **Features**:
  - Uses Google's speech recognition API
  - Preserves metadata (creation time, modification time, duration)
  - Organizes transcriptions into directories based on manifest data
  - Skips already transcribed files
  - Logs errors for failed transcriptions
- **Output**: Creates JSON files with transcriptions and metadata in `new_memories_transcripts` directory

### 3. Transcript Collection (`collect_transcripts.py`)
- **Purpose**: Aggregates all transcriptions into a single queryable JSON file
- **Features**:
  - Recursively finds all transcription JSON files
  - Adds task completion tracking with `is_completed` flag
  - Preserves file paths and metadata
  - Avoids duplicate entries
- **Output**: Creates/updates `collected_transcripts.json` with all transcriptions

## Workflow

1. **Record notes** using Apple's Voice Memos app
2. **Process recordings** by running the command:
   ```
   python extended_memory/copy_voice_memos.py --cutoff "YYYY-MM-DD HH:MM" && python3 extended_memory/transcribe_audio.py && python3 extended_memory/collect_transcripts.py
   ```
3. **Query your notes** using Amazon Q by asking questions about the content in `collected_transcripts.json`
4. **Track task completion** by asking Amazon Q to mark tasks as completed

## Directory Structure
- `/new_memories/` - Copied voice memo files
- `/new_memories_transcripts/` - Transcribed text and metadata
- `/collected_transcripts.json` - Aggregated transcriptions for querying
- `/transcription_errors.log` - Log of any transcription errors

## Advanced Features
- **Categorization**: Voice memos can be categorized by including a directory name in the recording title (format: "category/title")
- **Task Tracking**: Each transcription includes an `is_completed` flag that can be toggled to track task completion
- **Incremental Processing**: The system only processes new recordings, skipping those already transcribed

## Requirements
- Python 3.x
- Required Python packages:
  - speech_recognition
  - pydub
  - json
  - plistlib

## Integration with Amazon Q
The system is designed to work seamlessly with Amazon Q, allowing you to:
- Query your voice notes using natural language
- Mark tasks as completed
- Extract insights from your collected notes
