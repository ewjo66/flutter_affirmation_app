import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import 'favorites_screen.dart';
import 'add_quote_screen.dart';

class HomeScreen extends StatefulWidget {
  final QuoteService quoteService;

  const HomeScreen({super.key, required this.quoteService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final quote = widget.quoteService.dailyQuote;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Affirmations',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, size: 24),
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
          const SizedBox(width: 8),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote,
                                size: 48,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(
                                      alpha: 0.3,
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Transform.rotate(
                                angle: 3.14159,
                                child: Icon(
                                  Icons.format_quote,
                                  size: 48,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(
                                        alpha: 0.3,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                children: [
                                  Text(
                                    'Quote of the Day',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          letterSpacing: 0.5,
                                        ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    quote.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.6,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '— ${quote.author}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                context,
                                icon: widget.quoteService.isFavorite(quote)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                label: 'Like',
                                onPressed: () => _toggleFavorite(quote),
                                isActive: widget.quoteService.isFavorite(quote),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.share_outlined,
                                label: 'Share',
                                onPressed: () => _shareQuote(quote),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.refresh_outlined,
                                label: 'Next',
                                onPressed: _refreshQuote,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuoteScreen(
                quoteService: widget.quoteService,
              ),
            ),
          );
          if (result == true && mounted) {
            setState(() {});
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Quote'),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: isActive
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            foregroundColor:
                isActive ? Colors.red : Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Future<void> _refreshQuote() async {
    await widget.quoteService.loadNextQuote();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggleFavorite(Quote quote) async {
    await widget.quoteService.toggleFavorite(quote);
    if (mounted) setState(() {});
  }

  Future<void> _shareQuote(Quote quote) async {
    await Share.share('${quote.text}\n\n— ${quote.author}');
  }
}
