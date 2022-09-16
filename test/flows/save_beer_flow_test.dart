import 'package:beers_project/components/utils/mocks.dart';
import 'package:beers_project/main.dart';
import 'package:beers_project/model/beer.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a beer', (tester) async {
    final mockBeerDao = MockBeerDao();
    await tester.pumpWidget(MyApp(beerDao: mockBeerDao));

    //Verifica se o Dashboard existe
    final dashboardWidget = find.byType(Dashboard);
    expect(dashboardWidget, findsOneWidget);

    // Verifica se a feature de cervejas existe
    await checkIfExistsAndClickOnFeature(
        tester: tester, name: 'Cervejas', icon: Icons.sports_bar);
    await tester.pumpAndSettle();

    //Verifica se achou a lista de cervejas
    final beerList = find.byType(BeerList);
    expect(beerList, findsOneWidget);

    //Verifica se a chamada de busca do Dao funciona
    verify(mockBeerDao.findAllBeers());

    //Verifica se achou o botão de adicionar nova cerveja
    final addBeerButton = find.byType(FloatingActionButton);
    expect(addBeerButton, findsOneWidget);

    //Clica para adicionar nova cerveja
    await tester.tap(addBeerButton);
    await tester.pumpAndSettle();

    //Verifica se existe campo com nome da cerveja e adiciona um valor a ele
    final beerNameTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, "Nome da cerveja");
    });
    expect(beerNameTextField, findsOneWidget);
    await tester.enterText(beerNameTextField, 'Heineken');

    //Verifica se existe campo com marca da cerveja e adiciona um valor a ele
    final brandNameTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, "Marca da cerveja");
    });
    expect(brandNameTextField, findsOneWidget);
    await tester.enterText(brandNameTextField, 'Ambev');

    //Verifica se existe botão para adicionar cerveja e clica nele
    final createBeerButton = find.byType(ElevatedButton);
    expect(createBeerButton, findsOneWidget);
    await tester.tap(createBeerButton);
    await tester.pumpAndSettle();

    //Verifica se a chamada de save do Dao funciona
    verify(mockBeerDao
        .saveBeer(const Beer(beerName: 'Heineken', beerBrand: 'Ambev')));

    //Verifica se apareceu novamente a BeerList
    final beerListReturned = find.byType(BeerList);
    expect(beerListReturned, findsOneWidget);

    //Verifica novamente se a chamada de busca do Dao funciona
    verify(mockBeerDao.findAllBeers());
  });
}
