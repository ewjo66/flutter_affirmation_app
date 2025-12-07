# Daily Affirmations

A modern Flutter app that delivers daily inspirational quotes with a beautiful, minimalist design. Users can browse quotes, save favorites, add custom affirmations, and share inspiration with others. The app features both light and dark themes with a contemporary indigo color scheme.

## Features

### Core Features
- **Quote of the Day**: Get a new inspirational quote every day
- **Add Custom Quotes**: Create and save your own personal affirmations
- **Favorites System**: Save quotes you love with a heart icon (turns red when favorited)
- **Saved Quotes**: Access all your favorited quotes via the bookmark icon
- **Share Quotes**: Share inspiring quotes with friends and family
- **Next Quote**: Skip to a random quote anytime with the refresh button (fetches from API when online)
- **Pull to Refresh**: Get a new quote with pull-to-refresh gesture

### Design Features
- **Modern UI**: Clean Material Design 3 interface with indigo theme (#6366F1)
- **Dark Mode**: Automatically follows your device's system theme (no manual toggle)
- **Responsive Layout**: Beautiful on all screen sizes (mobile, tablet, web)
- **Smooth Animations**: Polished transitions and interactions
- **Icon Updates**: Heart icon for likes, bookmark icon for saved quotes
- **Quote Decoration**: Opening quotation mark icon above quotes

### Technical Features
- **Offline Support**: Works with a curated local set of 30+ affirmations
- **Custom Quote Storage**: User-added quotes persist locally
- **API Integration**: Fetches fresh quotes from quotable.io API when online
- **Smart Fallback**: Falls back to local quotes when offline
- **Data Persistence**: All favorites and custom quotes saved locally with SharedPreferences
- **Automated Testing**: Comprehensive unit and widget tests

## Screenshots

### Home Screen
- Opening quotation mark decoration
- Large, readable quote text with author
- Three action buttons: Like (heart), Share, Next (refresh)
- Floating action button to add new quotes
- Bookmark icon in app bar for saved quotes

### Add Quote Screen
- Simple form with quote text and author fields
- Form validation (minimum 10 characters for quote)
- Success/error feedback with snackbars
- Custom quotes integrate seamlessly with existing quotes

### Favorites Screen
- Grid/list of all saved quotes
- Quick access via bookmark icon in app bar
- Same interaction as home screen
- Empty state message when no favorites

## Getting Started

### Prerequisites

- Flutter SDK (3.38.4 or higher)
- Dart SDK (3.10.3 or higher)
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

### Running the App

#### For Web (Chrome)
```bash
flutter run -d chrome
```
Note: API calls will be blocked by CORS on web browsers. To test API functionality in Chrome during development only:
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```
⚠️ WARNING: Only use this flag for development/testing. Do not browse other websites with this Chrome window as security features are disabled

### For Android
```bash
flutter run
# or specifically target Android
flutter run -d android
```
### For IOS
```bash
flutter run -d ios
```

### For Windows Desktop
```bash
flutter run -d windows
```

### For macOS desktop
```bash
flutter run -d macos
```

### For running Tests
```bash
flutter test
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

### Theme System
- **Light Theme**: Clean white background with indigo accents
- **Dark Theme**: Deep dark background (#0F0F1E) with lighter text
- **Automatic Switching**: Follows device system settings (no manual toggle required)
- Consistent color scheme across all screens