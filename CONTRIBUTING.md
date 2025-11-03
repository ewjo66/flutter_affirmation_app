# Contributing to Daily Affirmations

Thank you for your interest in contributing to Daily Affirmations! This document provides guidelines and information for contributors.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/flutter_affirmation_app.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Run tests: `flutter test`
6. Commit your changes: `git commit -am 'Add some feature'`
7. Push to the branch: `git push origin feature/your-feature-name`
8. Submit a pull request

## Development Setup

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio IDE

### Installation
```bash
flutter pub get
```

### Running the App
```bash
# For development
flutter run

# For web
flutter run -d chrome

# For specific device
flutter devices  # List available devices
flutter run -d DEVICE_ID
```

## Code Style

This project follows the official Dart style guide and uses `flutter_lints` for linting.

### Run Linter
```bash
flutter analyze
```

### Format Code
```bash
flutter format .
```

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test
```bash
flutter test test/quote_service_test.dart
```

### Test Coverage
```bash
flutter test --coverage
```

## Project Structure

```
lib/
├── main.dart              # Entry point
├── models/                # Data models
├── services/              # Business logic
├── screens/               # UI screens
└── widgets/               # Reusable widgets

test/                      # Unit and widget tests
assets/                    # Static assets
  └── quotes/              # Local quote data
```

## Adding New Features

### Adding New Quotes
Edit `assets/quotes/affirmations.json` and add new quote objects:
```json
{
  "id": "31",
  "text": "Your inspirational quote here",
  "author": "Author Name"
}
```

### Adding New Screens
1. Create a new file in `lib/screens/`
2. Follow the existing screen pattern
3. Add tests in `test/`

### Adding Dependencies
1. Update `pubspec.yaml`
2. Run `flutter pub get`
3. Import and use in your code

## Pull Request Guidelines

- Write clear, descriptive commit messages
- Update documentation for any changed functionality
- Add tests for new features
- Ensure all tests pass
- Follow the existing code style
- Keep pull requests focused on a single feature or fix

## Reporting Issues

When reporting issues, please include:
- Flutter version (`flutter --version`)
- Device/platform information
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Maintain a positive environment

## License

By contributing, you agree that your contributions will be licensed under the project's MIT License.
