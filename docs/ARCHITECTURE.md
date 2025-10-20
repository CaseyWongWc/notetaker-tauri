# Architecture

## Overview
notetaker-tauri is a cross-platform desktop application for intelligent note-taking with built-in transcription, OCR, and semantic search capabilities. Built with Tauri (Rust backend) and React/TypeScript (frontend), it processes audio recordings, images, and text to create a unified knowledge base.

## Tech Stack
- **Frontend**: React + TypeScript + Vite
- **Desktop Runtime**: Tauri 2.x (Rust)
- **Database**: SQLite (embedded)
- **Worker Architecture**: Rust-based processing workers
  - Transcription worker (Whisper.cpp integration)
  - OCR worker (Tesseract or similar)
  - Embeddings worker (local embedding model)

## Architecture Layers

### 1. App Layer (`/app`)
- Tauri + React/TypeScript frontend
- Handles UI/UX, user input, and display
- Communicates with Rust backend via IPC (invoke commands)

### 2. Core Layer (`/core`)
- Rust workspace containing:
  - **common**: Shared types, utilities, database access
  - **workers/transcription**: Audio transcription logic
  - **workers/ocr**: Image text extraction
  - **embeddings**: Vector embedding generation

### 3. Data Layer (`/migrations`)
- SQLite schema migrations
- Tables: notes, embeddings, processing_queue

## MVP Features
1. **Text Notes**: Create, edit, and search plain text notes
2. **Audio Transcription**: Record or upload audio, automatic transcription
3. **OCR Processing**: Upload images, extract text via OCR
4. **Semantic Search**: Vector embeddings for similarity search
5. **Processing Queue**: Background job queue for async processing

## Data Flow
1. User creates note (text/audio/image) via UI
2. Frontend sends command to Tauri backend
3. Backend inserts note record, queues processing job
4. Worker processes job (transcription/OCR/embedding)
5. Results stored in database, UI updates
6. Search queries use embeddings for semantic matching

## Directory Structure
```
/app              - Tauri + React frontend
/core             - Rust workspace
  /common         - Shared Rust code
  /workers        - Processing workers
    /transcription
    /ocr
  /embeddings     - Vector embedding logic
/migrations       - SQL schema versions
/docs             - Documentation
```
