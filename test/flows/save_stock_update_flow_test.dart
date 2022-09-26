import 'package:beers_project/components/beer_card.dart';
import 'package:beers_project/components/response_dialog.dart';
import 'package:beers_project/components/stock_update_auth_dialog.dart';
import 'package:beers_project/components/utils/mocks.dart';
import 'package:beers_project/main.dart';
import 'package:beers_project/model/beer.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:beers_project/screens/stock_update/stock_update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import 'actions.dart';

void main() {
  late MockBeerDao mockBeerDao;
  late MockStockUpdateWebClient mockStockUpdateWebClient;

  setUp(() async {
    mockBeerDao = MockBeerDao();
    mockStockUpdateWebClient = MockStockUpdateWebClient();
  });
  testWidgets('Should save a stock update', (tester) async {
    //Sobe aplicação
    await tester.pumpWidget(MyApp(
      beerDao: mockBeerDao,
      stockUpdateWebClient: mockStockUpdateWebClient,
    ));

    //Verifica se o Dashboard existe
    final dashboardWidget = find.byType(Dashboard);
    expect(dashboardWidget, findsOneWidget);

    when(mockBeerDao.findAllBeers()).thenAnswer(((invocation) async {
      return [const Beer(beerName: 'IP04', beerBrand: 'Cervogia')];
    }));

    // Verifica se lista de cerveja existe e clica nela
    await checkIfExistsAndClickOnFeature(
        tester: tester, name: 'Cervejas', icon: Icons.sports_bar);
    await tester.pumpAndSettle();

    //Verifica se achou a lista de cervejas
    final beerList = find.byType(BeerList);
    expect(beerList, findsOneWidget);

    //Verifica se a chamada de busca do Dao funciona
    verify(mockBeerDao.findAllBeers()).called(1);

    //Verifica se existe um BeerItem e clica nele
    final beerItem = find.byWidgetPredicate((widget) {
      if (widget is BeerCard) {
        return widget.beer.beerName == 'IP04' &&
            widget.beer.beerBrand == 'Cervogia';
      }
      return false;
    });
    expect(beerItem, findsOneWidget);

    await tester.tap(beerItem);
    await tester.pumpAndSettle();

    // Verifica se achou o formulário de Stock Update
    final stockUpdateForm = find.byType(StockUpdateForm);
    expect(stockUpdateForm, findsOneWidget);

    //Verifica se achou os componentes do formulário
    final beerName = find.text('IP04');
    expect(beerName, findsOneWidget);

    final beerBrandName = find.text('Cervogia');
    expect(beerBrandName, findsOneWidget);

    final textFieldQuantity = find.byWidgetPredicate(
        (widget) => textFieldByLabelMatcher(widget, 'Quantidade'));
    expect(textFieldQuantity, findsOneWidget);
    await tester.enterText(textFieldQuantity, '266');

    //Verifica se existe botão de salvar e clica nele
    final saveStockUpdateButton = find.widgetWithText(ElevatedButton, 'Salvar');
    expect(saveStockUpdateButton, findsOneWidget);
    await tester.tap(saveStockUpdateButton);
    await tester.pumpAndSettle();

    //Verifica se existe Auth Dialog
    final stockUpdateAuthDialog = find.byType(StockUpdateAuthDialog);
    expect(stockUpdateAuthDialog, findsOneWidget);

    //Verifica os campos existentes no Auth Dialog
    final textFieldPassword =
        find.byKey(stockUpdateAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockStockUpdateWebClient.saveStockUpdate(
            StockUpdate(
              id: '123',
              beerName: 'IP04',
              beerQuantity: 266,
            ),
            '1000'))
        .thenAnswer((_) async =>
            StockUpdate(id: '123', beerName: 'IP04', beerQuantity: 266));

    //Clica em "confirm" para criar o Stock Update
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    //Verifica se aparece o Success Dialog
    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    //Verifica se existe botão de confirm e clica nele
    final okButton = find.widgetWithText(TextButton, 'Confirm');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    //Verifica se retorna para lista de cervejas
    final beerListBack = find.byType(BeerList);
    expect(beerListBack, findsOneWidget);
  });
}
