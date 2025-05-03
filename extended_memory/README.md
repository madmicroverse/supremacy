# supremacy
## extended memory

I will record all my notes using the "voice memos"

running 

python extended_memory/copy_voice_memos.py --cutoff "2025-05-02 19:49" && python3 extended_memory/transcribe_audio.py && python3 extended_memory/collect_transcripts.py

will collect and process latest notes and compile then into extended_memory/collected_transcripts.json

And now we can query the file using amazon q chat asking questions about extended_memory/collected_transcripts.json
and when a task is done we can ask him to mark it as such.