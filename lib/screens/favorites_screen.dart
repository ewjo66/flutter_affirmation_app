import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';

class FavoritesScreen extends StatefulWidget {
  final QuoteService quoteService;

  const FavoritesScreen({Key? key, required this.quoteService}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = widget.quoteService.favoriteQuotes;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart icon to save quotes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final quote = favorites[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '— ${quote.author}',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.share, size: 20),
                              color: Colors.teal,
                              onPressed: () => _shareQuote(quote),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20),
                              color: Colors.red[400],
                              onPressed: () => _removeFavorite(quote),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _shareQuote(Quote quote) {
    Share.share('${quote.text}\n\n— ${quote.author}');
  }

  void _removeFavorite(Quote quote) {
    widget.quoteService.toggleFavorite(quote);
    setState(() {});
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
