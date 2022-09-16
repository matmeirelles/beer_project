import 'package:beers_project/components/utils/mocks.dart';
import 'package:beers_project/main.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'actions.dart';

void main() {
  testWidgets('Should save a stock update', (tester) async {
    //Sobe aplicação
    final mockBeerDao = MockBeerDao();
    await tester.pumpWidget(MyApp(beerDao: mockBeerDao));

    //Verifica se o Dashboard existe
    final dashboardWidget = find.byType(Dashboard);
    expect(dashboardWidget, findsOneWidget);

    // Verifica se lista de cerveja existe e clica nela
    await checkIfExistsAndClickOnFeature(
        tester: tester, name: 'Cervejas', icon: Icons.sports_bar);
    await tester.pumpAndSettle();

    //Verifica se achou a lista de cervejas
    final beerList = find.byType(BeerList);
    expect(beerList, findsOneWidget);

    //Verifica se a chamada de busca do Dao funciona
    verify(mockBeerDao.findAllBeers());
  });
}
