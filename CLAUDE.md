# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ParkGisa Board Two (박기사보드판) is a Flutter application for construction site photo documentation. It allows construction workers to capture photos with contextual overlays containing date, location, work type, and descriptions.

## Development Commands

### Running the App
```bash
flutter run                 # Run on connected device/emulator
flutter run -d ios         # Run on iOS
flutter run -d android     # Run on Android
```

### Building
```bash
flutter build ios          # Build for iOS
flutter build android      # Build for Android APK
flutter build appbundle    # Build Android App Bundle
```

### Code Generation (Drift Database)
```bash
flutter pub run build_runner build              # Generate database files
flutter pub run build_runner build --delete-conflicting-outputs  # Force regenerate
flutter pub run build_runner watch              # Watch mode for development
```

### Testing & Analysis
```bash
flutter test               # Run unit tests
flutter analyze            # Static code analysis
flutter pub outdated       # Check for dependency updates
```

### Dependencies
```bash
flutter pub get            # Install dependencies
flutter pub upgrade        # Upgrade dependencies
```

## Architecture & Key Components

### Database Layer (Drift)
- **Location**: `lib/data/database/app_database.dart`
- **Tables**: 
  - `PhotoInfos`: Stores photo metadata with location, work type, and timestamps
  - `WorkTypes`: Tracks frequently used work types with usage counts
  - `LocationHistories`: Stores location history with usage frequency
- **Generated Code**: `app_database.g.dart` (regenerate with `build_runner`)
- **Key Pattern**: Repository pattern with type-safe queries

### State Management
- **Provider**: App-wide database instance management in `main.dart`
- **Flutter Hooks**: Local widget state management (useState, useTextEditingController, useEffect)
- **Pattern**: Single database instance provided at app root, consumed via `Provider.of<AppDatabase>(context)`

### Navigation Flow
1. **HomeScreen**: Bottom navigation between Board and Gallery tabs
2. **BoardPage**: Camera preview with input fields → navigates to PhotoPreviewPage
3. **PhotoPreviewPage**: Takes photo from camera/gallery, shows preview with overlay, saves to database
4. **GalleryPage**: Browse saved photos with filtering options

### Core Features Implementation

#### Camera Integration
- **Current Status**: Camera preview temporarily commented out in `board_page.dart` (lines 121-127)
- **TODO**: Move camera capture to PhotoPreviewPage (see TODO comment line 117)
- **Permissions**: Handled via `PermissionsHandler` utility class

#### Photo Processing
- **ImageSaver**: Combines original photo with overlay information
- **Storage**: Photos saved to app documents directory and device gallery
- **Metadata**: GPS coordinates, timestamps, and custom fields stored in database

#### Location Services
- **Auto-detection**: GPS location fetched on page load
- **Geocoding**: Converts coordinates to human-readable addresses
- **Caching**: Location history stored for quick access

### Critical Implementation Notes

1. **Board Overlay Positioning**: Currently shows at bottom of camera preview area
2. **Image Path Handling**: PhotoPreviewPage expects `imagePath` parameter (currently empty string passed from BoardPage)
3. **Database Migrations**: Schema version 1, handle migrations in `AppDatabase.schemaVersion`
4. **Custom Fields**: JSON-encoded in database for flexible data storage

### Platform-Specific Considerations

#### iOS
- Info.plist permissions configured for Camera, Photos, and Location
- Korean localization for permission descriptions
- Minimum iOS version requirements set in Runner.xcodeproj

#### Android
- Manifest permissions required for camera and storage
- Consider Android 13+ photo picker permissions

## Current Development Status

- Flutter Hooks recently integrated (refactoring in progress)
- Camera functionality being moved from BoardPage to PhotoPreviewPage
- Board overlay component shared between preview screens