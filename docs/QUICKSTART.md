# Quick Start Guide

Get Daily Affirmations up and running in minutes!

## Prerequisites

Before you begin, ensure you have:
- Flutter SDK 3.0.0 or higher installed
- An IDE (VS Code or Android Studio)
- A device/emulator or web browser

## Installation Steps

### 1. Clone the Repository
```bash
git clone https://github.com/ewjo66/flutter_affirmation_app.git
cd flutter_affirmation_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App

#### On Mobile (Android/iOS)
```bash
# Check available devices
flutter devices

# Run on connected device
flutter run
```

#### On Web
```bash
flutter run -d chrome
```

#### On Specific Platform
```bash
# Android
flutter run -d android

# iOS (requires macOS)
flutter run -d ios

# Web
flutter run -d web
```

## First Launch

When you first launch the app:

1. **Quote of the Day**: You'll see an inspirational affirmation
2. **Save Favorites**: Tap the heart icon to save quotes you love
3. **Share**: Tap the share button to share quotes with friends
4. **Refresh**: Pull down or tap the refresh button for a new quote
5. **View Favorites**: Tap the heart icon in the app bar

## Features Overview

### Daily Quote
- Automatically changes each day
- Cached for offline viewing
- Pull to refresh for new quotes

### Favorites
- Save unlimited quotes
- Access from favorites screen (heart icon in app bar)
- Share or remove saved quotes
- Persists across app restarts

### Sharing
- Share via any app (messages, social media, email)
- Formatted with quote and author

### Offline Mode
- Works completely offline with 30 built-in quotes
- No internet required for basic functionality
- Optional online features (API quotes)

## Troubleshooting

### Build Errors
```bash
# Clean build cache
flutter clean
flutter pub get

# Rebuild
flutter run
```

### Dependencies Issues
```bash
# Update dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

### Device Not Detected
```bash
# List available devices
flutter devices

# For Android, ensure USB debugging is enabled
# For iOS, ensure device is trusted
```

## Development Mode

Run with hot reload for development:
```bash
flutter run
# Press 'r' to hot reload
# Press 'R' to hot restart
# Press 'q' to quit
```

## Building for Production

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS App
```bash
flutter build ios --release
# Opens in Xcode for final steps
```

### Web
```bash
flutter build web --release
# Output: build/web/
```

## Next Steps

- Check out the [Architecture Documentation](ARCHITECTURE.md)
- Read the [Contributing Guide](../CONTRIBUTING.md)
- Explore the code in `lib/` directory
- Add your own quotes to `assets/quotes/affirmations.json`

## Support

If you encounter issues:
1. Check existing GitHub Issues
2. Review the documentation
3. Create a new issue with details

Enjoy your daily dose of inspiration! ✨
