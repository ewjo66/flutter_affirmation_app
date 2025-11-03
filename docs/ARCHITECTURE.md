# Architecture Documentation

## Overview

Daily Affirmations is built using a simple, maintainable architecture that follows Flutter best practices and emphasizes offline-first functionality.

## Architecture Pattern

The app uses a **Service-based architecture** with clear separation of concerns:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  (Screens & Widgets - UI Logic)     │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│         Service Layer               │
│  (QuoteService - Business Logic)    │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│          Data Layer                 │
│  (SharedPreferences, Assets, HTTP)  │
└─────────────────────────────────────┘
```

## Core Components

### 1. Models (`lib/models/`)

**Quote Model**
- Represents a single quote/affirmation
- Handles JSON serialization/deserialization
- Implements equality comparison for favorite management

```dart
class Quote {
  final String id;
  final String text;
  final String author;
}
```

### 2. Services (`lib/services/`)

**QuoteService**
- Singleton service managing all quote operations
- Responsibilities:
  - Loading local quotes from assets
  - Managing daily quote selection
  - Handling favorites persistence
  - Optional API integration
  - Offline-first design

Key Features:
- **Daily Quote Logic**: One quote per day, cached locally
- **Favorites Management**: Persistent storage using SharedPreferences
- **API Integration**: Falls back to local quotes if API fails
- **Offline Support**: Always works with local data

### 3. Screens (`lib/screens/`)

**HomeScreen**
- Displays the quote of the day
- Provides refresh functionality
- Allows favoriting and sharing
- Pull-to-refresh gesture support

**FavoritesScreen**
- Lists all saved favorite quotes
- Supports sharing individual quotes
- Allows removing quotes from favorites

### 4. Data Persistence

**Local Storage (SharedPreferences)**
- Favorite quotes list
- Last quote date (for daily rotation)
- Current daily quote cache

**Asset Storage**
- 30 curated affirmations in JSON format
- Always available offline
- Fallback when API is unavailable

**API Integration (Optional)**
- Uses Quotable.io API
- Fetches fresh quotes when online
- Gracefully degrades to local quotes

## Data Flow

### Daily Quote Selection
```
App Launch
    ↓
Check Date
    ↓
Same Day? → Load Cached Quote
    ↓
New Day? → Select Random Quote from Local Set
    ↓
Save to Cache
    ↓
Display
```

### Refresh Flow
```
User Pulls to Refresh
    ↓
Try API Request (10s timeout)
    ↓
Success? → Use API Quote
    ↓
Failure? → Use Random Local Quote
    ↓
Cache & Display
```

### Favorites Flow
```
Toggle Favorite
    ↓
Check if Already Favorite
    ↓
Add/Remove from List
    ↓
Save to SharedPreferences
    ↓
Update UI
```

## State Management

The app uses **StatefulWidget** with `setState()` for simplicity:
- Appropriate for this small app scope
- Easy to understand and maintain
- No external state management library needed

For larger features, consider:
- Provider for dependency injection
- Riverpod for more complex state
- BLoC for enterprise applications

## Offline-First Design

1. **Always Load Local First**: App starts with local data
2. **Optional Network**: API calls are enhancements, not requirements
3. **Graceful Degradation**: Network failures don't break functionality
4. **Persistent Cache**: Daily quotes cached for offline viewing

## Error Handling

- Try-catch blocks around all async operations
- Fallback to local data on network errors
- User-friendly error messages via SnackBar
- Console logging for debugging

## Testing Strategy

### Unit Tests
- Quote model serialization
- QuoteService business logic
- Favorite management

### Widget Tests
- Screen rendering
- User interactions
- Navigation

### Integration Tests
- End-to-end user flows
- API integration
- Data persistence

## Future Enhancements

Potential architectural improvements:
1. **Repository Pattern**: Abstract data sources
2. **Dependency Injection**: Use Provider or GetIt
3. **State Management**: Migrate to Riverpod/BLoC
4. **Database**: Use SQLite for larger quote collections
5. **Notifications**: Daily reminder system
6. **Themes**: Dark mode support
7. **Analytics**: Track user engagement
8. **Multi-language**: Internationalization support

## Performance Considerations

- **Asset Loading**: Quotes loaded once at startup
- **Memory Usage**: Small dataset (30 quotes) minimal impact
- **UI Rendering**: Stateless widgets where possible
- **API Calls**: Debounced refresh to prevent spam
- **Caching**: Daily quote cached to avoid redundant operations

## Security

- No sensitive data stored
- API calls over HTTPS
- No authentication required
- No user data collection

## Dependencies

- **shared_preferences**: Local key-value storage
- **http**: Network requests
- **share_plus**: Native sharing functionality
- **intl**: Date formatting
- **flutter_lints**: Code quality

## Build Configuration

### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Kotlin version: 1.9.0

### iOS
- Minimum iOS: 12.0
- Swift version: 5

### Web
- Progressive Web App capable
- Responsive design
- Offline support via service workers
