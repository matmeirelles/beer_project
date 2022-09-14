import 'dart:math';

import 'package:beers_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Should display the main image when the Dashboard opens',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Dashboard()));
      final mainImage = find.byType(Image);

      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
    'Should display a feature when the Dashboard opens',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Dashboard()));
      final featureItem = find.byType(FeatureItem);

      expect(featureItem, findsWidgets);
    },
  );
}
