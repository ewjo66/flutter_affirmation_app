import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_affirmations/models/quote.dart';
import 'package:daily_affirmations/services/quote_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuoteService', () {
    late QuoteService quoteService;

    setUp(() async {
      // Mock SharedPreferences with empty data
      SharedPreferences.setMockInitialValues({});
      quoteService = QuoteService();
    });

    test('should initialize with quotes', () async {
      await quoteService.initialize();
      expect(quoteService.allQuotes, isNotEmpty);
    });

    test('should provide a daily quote', () async {
      await quoteService.initialize();
      expect(quoteService.dailyQuote, isNotNull);
    });

    test('should add and remove favorites', () async {
      await quoteService.initialize();
      final quote = quoteService.allQuotes.first;

      expect(quoteService.isFavorite(quote), isFalse);

      await quoteService.toggleFavorite(quote);
      expect(quoteService.isFavorite(quote), isTrue);
      expect(quoteService.favoriteQuotes, contains(quote));

      await quoteService.toggleFavorite(quote);
      expect(quoteService.isFavorite(quote), isFalse);
      expect(quoteService.favoriteQuotes, isNot(contains(quote)));
    });

    test('should maintain favorites list', () async {
      await quoteService.initialize();
      final quote1 = quoteService.allQuotes[0];
      final quote2 = quoteService.allQuotes[1];

      await quoteService.toggleFavorite(quote1);
      await quoteService.toggleFavorite(quote2);

      expect(quoteService.favoriteQuotes.length, equals(2));
      expect(quoteService.favoriteQuotes, contains(quote1));
      expect(quoteService.favoriteQuotes, contains(quote2));
    });
  });

  group('Quote', () {
    test('should create Quote from JSON', () {
      final json = {
        'id': '1',
        'text': 'Test quote',
        'author': 'Test Author',
      };

      final quote = Quote.fromJson(json);

      expect(quote.id, equals('1'));
      expect(quote.text, equals('Test quote'));
      expect(quote.author, equals('Test Author'));
    });

    test('should convert Quote to JSON', () {
      final quote = Quote(
        id: '1',
        text: 'Test quote',
        author: 'Test Author',
      );

      final json = quote.toJson();

      expect(json['id'], equals('1'));
      expect(json['text'], equals('Test quote'));
      expect(json['author'], equals('Test Author'));
    });

    test('should compare quotes by id', () {
      final quote1 = Quote(id: '1', text: 'Text', author: 'Author');
      final quote2 = Quote(id: '1', text: 'Different', author: 'Different');
      final quote3 = Quote(id: '2', text: 'Text', author: 'Author');

      expect(quote1, equals(quote2));
      expect(quote1, isNot(equals(quote3)));
    });
  });
}
