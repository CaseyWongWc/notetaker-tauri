-- Initial schema for notetaker-tauri
-- SQLite database v0

CREATE TABLE IF NOT EXISTS notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  source_type TEXT CHECK(source_type IN ('text', 'audio', 'image')) NOT NULL,
  source_path TEXT,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  updated_at INTEGER NOT NULL DEFAULT (unixepoch())
);

CREATE TABLE IF NOT EXISTS embeddings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  note_id INTEGER NOT NULL,
  chunk_text TEXT NOT NULL,
  embedding_vector BLOB NOT NULL,
  chunk_index INTEGER NOT NULL,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  FOREIGN KEY (note_id) REFERENCES notes(id) ON DELETE CASCADE
);

CREATE INDEX idx_notes_source_type ON notes(source_type);
CREATE INDEX idx_notes_created_at ON notes(created_at DESC);
CREATE INDEX idx_embeddings_note_id ON embeddings(note_id);

CREATE TABLE IF NOT EXISTS processing_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  note_id INTEGER NOT NULL,
  job_type TEXT CHECK(job_type IN ('transcription', 'ocr', 'embedding')) NOT NULL,
  status TEXT CHECK(status IN ('pending', 'processing', 'completed', 'failed')) DEFAULT 'pending',
  error_message TEXT,
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),
  completed_at INTEGER,
  FOREIGN KEY (note_id) REFERENCES notes(id) ON DELETE CASCADE
);

CREATE INDEX idx_queue_status ON processing_queue(status, created_at);
