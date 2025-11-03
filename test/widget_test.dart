import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_affirmations/main.dart';

void main() {
  testWidgets('App starts with correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyAffirmationsApp());
    await tester.pumpAndSettle();

    expect(find.text('Daily Affirmations'), findsOneWidget);
  });

  testWidgets('App shows loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyAffirmationsApp());
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
