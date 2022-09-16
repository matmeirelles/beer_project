import 'package:beers_project/components/utils/mocks.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';

void main() {
  testWidgets(
    'Should display the main image when the Dashboard opens',
    (WidgetTester tester) async {
      final mockBeerDao = MockBeerDao();
      await tester.pumpWidget(MaterialApp(
          home: Dashboard(
        beerDao: mockBeerDao,
      )));
      final mainImage = find.byType(Image);

      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
    'Should display the beer feature when the Dashboard opens',
    (WidgetTester tester) async {
      final mockBeerDao = MockBeerDao();
      await tester.pumpWidget(MaterialApp(
          home: Dashboard(
        beerDao: mockBeerDao,
      )));
      final beerFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(
              widget: widget, name: 'Cervejas', icon: Icons.sports_bar));

      expect(beerFeatureItem, findsWidgets);
    },
  );

  testWidgets(
    'Should display the brand feature when the Dashboard opens',
    (WidgetTester tester) async {
      final mockBeerDao = MockBeerDao();
      await tester.pumpWidget(MaterialApp(
          home: Dashboard(
        beerDao: mockBeerDao,
      )));
      final brandFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(
              widget: widget, name: 'Marcas', icon: Icons.home_filled));
      expect(brandFeatureItem, findsOneWidget);
    },
  );
}
