import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/quote.dart';

class QuoteService {
  static const String _favoritesKey = 'favorite_quotes';
  static const String _lastQuoteDateKey = 'last_quote_date';
  static const String _dailyQuoteKey = 'daily_quote';
  static const String _customQuotesKey = 'custom_quotes';

  List<Quote> _allQuotes = [];
  List<Quote> _favoriteQuotes = [];
  List<Quote> _customQuotes = [];
  Quote? _dailyQuote;

  Future<void> initialize() async {
    await _loadLocalQuotes();
    await _loadCustomQuotes();
    await _loadFavorites();
    await _loadOrSetDailyQuote();
  }

  Future<void> _loadLocalQuotes() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/quotes/affirmations.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      _allQuotes = jsonData.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading local quotes: $e');
      _allQuotes = [];
    }
  }

  Future<void> _loadCustomQuotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? customJson = prefs.getString(_customQuotesKey);
      if (customJson != null) {
        final List<dynamic> jsonData = json.decode(customJson);
        _customQuotes = jsonData.map((json) => Quote.fromJson(json)).toList();
        _allQuotes.addAll(_customQuotes);
      }
    } catch (e) {
      debugPrint('Error loading custom quotes: $e');
      _customQuotes = [];
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_favoritesKey);
      if (favoritesJson != null) {
        final List<dynamic> jsonData = json.decode(favoritesJson);
        _favoriteQuotes = jsonData.map((json) => Quote.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error loading favorites: $e');
      _favoriteQuotes = [];
    }
  }

  Future<void> _loadOrSetDailyQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String? lastDate = prefs.getString(_lastQuoteDateKey);

    if (lastDate == today) {
      final String? quoteJson = prefs.getString(_dailyQuoteKey);
      if (quoteJson != null) {
        _dailyQuote = Quote.fromJson(json.decode(quoteJson));
        return;
      }
    }

    _dailyQuote = _selectRandomQuote();
    if (_dailyQuote != null) {
      await prefs.setString(_lastQuoteDateKey, today);
      await prefs.setString(_dailyQuoteKey, json.encode(_dailyQuote!.toJson()));
    }
  }

  Quote? _selectRandomQuote() {
    if (_allQuotes.isEmpty) return null;
    final random = Random();
    return _allQuotes[random.nextInt(_allQuotes.length)];
  }

  Quote? get dailyQuote => _dailyQuote;

  List<Quote> get allQuotes => List.unmodifiable(_allQuotes);

  List<Quote> get favoriteQuotes => List.unmodifiable(_favoriteQuotes);

  bool isFavorite(Quote quote) {
    return _favoriteQuotes.any((q) => q.id == quote.id);
  }

  Future<void> toggleFavorite(Quote quote) async {
    if (isFavorite(quote)) {
      _favoriteQuotes.removeWhere((q) => q.id == quote.id);
    } else {
      _favoriteQuotes.add(quote);
    }
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> favoritesJson =
        _favoriteQuotes.map((q) => q.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(favoritesJson));
  }

  Future<Quote?> fetchQuoteFromApi() async {
    try {
      final response = await http
          .get(
            Uri.parse('https://api.quotable.io/random'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Quote(
          id: data['_id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
          text: data['content'] ?? '',
          author: data['author'] ?? 'Unknown',
        );
      }
    } catch (e) {
      debugPrint('Error fetching quote from API: $e');
    }
    return null;
  }

  Future<void> refreshDailyQuote() async {
    Quote? apiQuote = await fetchQuoteFromApi();
    if (apiQuote != null) {
      _dailyQuote = apiQuote;
      final prefs = await SharedPreferences.getInstance();
      final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await prefs.setString(_lastQuoteDateKey, today);
      await prefs.setString(_dailyQuoteKey, json.encode(_dailyQuote!.toJson()));
    } else {
      _dailyQuote = _selectRandomQuote();
    }
  }

  Future<void> loadNextQuote() async {
    // Try API first, fallback to local
    Quote? apiQuote = await fetchQuoteFromApi();
    if (apiQuote != null) {
      _dailyQuote = apiQuote;
    } else {
      _dailyQuote = _selectRandomQuote();
    }

    if (_dailyQuote != null) {
      final prefs = await SharedPreferences.getInstance();
      final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await prefs.setString(_lastQuoteDateKey, today);
      await prefs.setString(_dailyQuoteKey, json.encode(_dailyQuote!.toJson()));
    }
  }

  Future<void> addCustomQuote(String text, String author) async {
    final newQuote = Quote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      author: author,
    );

    _customQuotes.add(newQuote);
    _allQuotes.add(newQuote);

    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> customJson =
        _customQuotes.map((q) => q.toJson()).toList();
    await prefs.setString(_customQuotesKey, json.encode(customJson));
  }
}
