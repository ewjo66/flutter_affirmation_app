# Daily Affirmations

A minimalist Flutter app that surfaces a "Quote of the Day," lets users save favorites, and share inspiration. It works offline with a local quote set and optionally pulls fresh quotes from a public API.

## Features

- **Quote of the Day**: Get a new inspirational quote every day
- **Offline Support**: Works with a curated local set of 30 affirmations
- **Favorites**: Save your favorite quotes for later
- **Share**: Share inspiring quotes with friends and family
- **API Integration**: Optionally fetch fresh quotes from quotable.io API
- **Pull to Refresh**: Get a new quote anytime with pull-to-refresh
- **Minimalist Design**: Clean, focused interface for daily inspiration

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile) or Chrome (for web)

### Installation

1. Clone the repository
```bash
git clone https://github.com/ewjo66/flutter_affirmation_app.git
cd flutter_affirmation_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── quote.dart           # Quote data model
├── services/
│   └── quote_service.dart   # Quote management service
└── screens/
    ├── home_screen.dart     # Main quote display
    └── favorites_screen.dart # Favorites list
assets/
└── quotes/
    └── affirmations.json    # Local quote collection
```

## Features in Detail

### Offline Functionality
The app includes 30 curated affirmations stored locally, ensuring the app works without internet connection.

### Daily Quote Logic
- A new quote is selected each day automatically
- The same quote is displayed throughout the day
- Pull to refresh or tap the refresh button to get a new quote from the API

### Favorites Management
- Tap the heart icon to save/unsave quotes
- Access all favorites from the favorites screen
- Share or remove favorites with ease

### API Integration
The app can fetch quotes from the [Quotable.io](https://api.quotable.io) public API when online, providing an endless variety of inspiration.

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Dependencies

- `shared_preferences`: Local data persistence
- `http`: API requests
- `share_plus`: Share functionality
- `intl`: Date formatting

## License

This project is open source and available under the MIT License.