import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final QuoteService quoteService;

  const HomeScreen({Key? key, required this.quoteService}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    final quote = widget.quoteService.dailyQuote;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Daily Affirmations'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    quoteService: widget.quoteService,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: quote == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshQuote,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 100,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.format_quote,
                            size: 48,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 32),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Quote of the Day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    quote.text,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '— ${quote.author}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _toggleFavorite(quote),
                                icon: Icon(
                                  widget.quoteService.isFavorite(quote)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                label: Text(
                                  widget.quoteService.isFavorite(quote)
                                      ? 'Saved'
                                      : 'Save',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () => _shareQuote(quote),
                                icon: const Icon(Icons.share),
                                label: const Text('Share'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[700],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_isRefreshing) ...[
                            const SizedBox(height: 24),
                            const CircularProgressIndicator(),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isRefreshing ? null : _refreshQuote,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Future<void> _refreshQuote() async {
    setState(() => _isRefreshing = true);
    await widget.quoteService.refreshDailyQuote();
    setState(() => _isRefreshing = false);
  }

  void _toggleFavorite(Quote quote) {
    widget.quoteService.toggleFavorite(quote);
    setState(() {});
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.quoteService.isFavorite(quote)
              ? 'Added to favorites'
              : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareQuote(Quote quote) {
    Share.share('${quote.text}\n\n— ${quote.author}');
  }
}
