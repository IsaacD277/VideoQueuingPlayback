# Video Queuing Playback - Still In Development

A native macOS video player application built with SwiftUI that allows for directory-based video browsing and playback. Similar to the idea of ProPresenter, but with a focus on video playback and queuing.

## Overview

ACSPlayer is a lightweight macOS application designed to help you browse and play video files from selected folders with an intuitive grid-based interface. The app automatically generates thumbnails for videos.

## Features

- **Folder-based Video Library**: Browse videos from any folder on your Mac
- **Automatic Video Detection**: Identifies MP4 and MOV files in selected directories
- **Thumbnail Generation**: Automatically creates preview thumbnails for each video
- **Grid Display**: View videos in a responsive grid layout
- **Native macOS Integration**: Uses native file picker for folder selection and video handling

## System Requirements

- macOS 11.0 or later
- Swift 5.5+
- Xcode 13+ (for development)

## How It Works

ACSPlayer is built using SwiftUI and AVKit and consists of three main components:

### ContentView
The main view controller that handles:
- Folder selection via NSOpenPanel
- Video browsing and filtering
- Thumbnail generation using AVAssetImageGenerator
- Grid layout management
- Video selection and persistence

### VideoThumbnailView
A reusable component that displays:
- Video preview thumbnails with 16:9 aspect ratio
- File names beneath thumbnails
- Selection state with blue border highlight

### FileListView
A utility view that demonstrates file browsing capabilities:
- Lists files with specific extensions
- Accesses user's home directory

## Usage

1. Launch the application
2. Click "Select Folder" to choose a directory containing videos
3. Browse the grid of video thumbnails
4. Click on a thumbnail to select a video for playback

## Development

The application is structured around SwiftUI's state management system:
- `@State` variables track the UI state
- Background processing for thumbnail generation
- UserDefaults for basic persistence

## Future Enhancements

- Video playback controls
- Playlist functionality
- Search and filtering options
- Video metadata display
- Custom folders list
- Dark mode support

## Author

Isaac D2
