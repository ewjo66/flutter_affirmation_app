import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_affirmations/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App shows loading indicator initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DailyAffirmationsApp());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading Affirmations...'), findsOneWidget);
  });

  testWidgets('App loads without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyAffirmationsApp());

    // Wait for initialization - pump multiple times
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 500));
    }

    // Just verify the app widget exists (doesn't crash)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
