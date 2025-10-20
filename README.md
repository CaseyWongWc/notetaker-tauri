# notetaker-tauri

**Cross-platform intelligent note-taking application with transcription, OCR, and semantic search**

## Overview

notetaker-tauri is a desktop application built with Tauri 2.x and React/TypeScript that enables users to create, manage, and search notes from multiple input types (text, audio, images). It features local processing for transcription and OCR, plus semantic search capabilities using vector embeddings.

## Architecture

### Tech Stack
- **Frontend**: React + TypeScript + Vite
- **Desktop Runtime**: Tauri 2.x (Rust)
- **Database**: SQLite (embedded)
- **Processing Workers**: Rust-based workers for transcription, OCR, and embeddings

### Layers
1. **App Layer** (`/app`): Tauri + React frontend with UI/UX
2. **Core Layer** (`/core`): Rust workspace with shared code and processing workers
3. **Data Layer** (`/migrations`): SQLite schema and migrations

### Rust Workspace (`/core`)
- **common**: Shared types, utilities, database access
- **workers/transcription**: Audio transcription using Whisper.cpp
- **workers/ocr**: Image text extraction using Tesseract
- **embeddings**: Vector embedding generation for semantic search

## MVP Features

1. ✅ **Text Notes**: Create, edit, and search plain text notes
2. 🎙️ **Audio Transcription**: Upload or record audio → automatic transcription
3. 📷 **OCR Processing**: Upload images → extract text via OCR
4. 🔍 **Semantic Search**: Vector embeddings enable similarity-based search
5. ⚙️ **Background Processing**: Async job queue for transcription/OCR/embedding tasks

## Directory Structure

```
notetaker-tauri/
├── app/              # Tauri + React frontend
├── core/             # Rust workspace
│   ├── common/       # Shared Rust code (types, DB, utils)
│   ├── workers/      # Processing workers
│   │   ├── transcription/  # Whisper.cpp integration
│   │   └── ocr/            # Tesseract integration
│   └── embeddings/   # Vector embedding generation
├── migrations/       # SQL schema versions
├── docs/            # Design documentation
│   ├── ARCHITECTURE.md  # System design
│   └── D1-D3.md        # Requirements & implementation plan
├── LICENSE           # MIT License
└── README.md         # This file
```

## Getting Started

### Prerequisites
- Node.js 18+ and npm/yarn
- Rust 1.70+
- Tauri CLI: `cargo install tauri-cli`

### Development

```bash
# Install dependencies
cd app && npm install

# Run development server
npm run tauri dev

# Build for production
npm run tauri build
```

### Database

SQLite schema is managed via migrations in `/migrations/`. The initial schema (`0001_init.sql`) defines tables for notes, embeddings, and processing queues.

## License

MIT License - see [LICENSE](LICENSE) for details.
