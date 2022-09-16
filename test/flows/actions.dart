import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> checkIfExistsAndClickOnFeature({
  required WidgetTester tester,
  required String name,
  required IconData icon,
}) async {
  final beerFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget: widget, name: name, icon: icon));
  expect(beerFeatureItem, findsOneWidget);
  return tester.tap(beerFeatureItem);
}
