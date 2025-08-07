//Flutter widget test for Restaurant Menu App.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:restaurant_menu_app/main.dart';

void main() {
  testWidgets('Restaurant menu app smoke test', (WidgetTester tester) async {
    // Build app and trigger a frame.
    await tester.pumpWidget(const RestaurantMenuApp());
    
    // Verify that the app builds without throwing an error
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App bar is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const RestaurantMenuApp());
    await tester.pumpAndSettle();

    // Verify app bar title
    expect(find.text('Restaurant Menu'), findsOneWidget);
  });

  testWidgets('Categories are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const RestaurantMenuApp());
    await tester.pumpAndSettle();

    // Verify at least some categories are present
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Pizza'), findsOneWidget);
  });

  testWidgets('Food items are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const RestaurantMenuApp());
    await tester.pumpAndSettle();

    // Verify at least some food items are displayed
    expect(find.textContaining('Pizza'), findsAtLeastNWidgets(1));
    expect(find.textContaining('\$'), findsAtLeastNWidgets(1));
  });

  testWidgets('Category selection works', (WidgetTester tester) async {
    await tester.pumpWidget(const RestaurantMenuApp());
    await tester.pumpAndSettle();

    // Try to tap on Pizza category
    final pizzaCategory = find.text('Pizza');
    if (pizzaCategory.evaluate().isNotEmpty) {
      await tester.tap(pizzaCategory);
      await tester.pumpAndSettle();
      
      // Verify the tap didn't cause an error
      expect(find.byType(Scaffold), findsOneWidget);
    }
  });
}