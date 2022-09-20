import 'dart:math';

import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the quantity when create a Stock Update', () {
    final StockUpdate stockUpdate =
        StockUpdate(id: '~', beerName: '', beerQuantity: 10);
    expect(stockUpdate.beerQuantity, 10);
  });

  test('Should throw error when the quantity is equal or lower then zero', () {
    expect(() => StockUpdate(id: '', beerName: '', beerQuantity: 0),
        throwsAssertionError);
  });

  test('Should return a stock update when save a new stock update', () async {
    final StockUpdate newStockUpdate = StockUpdate(
        id: Random().nextInt(10000).toString(),
        beerName: 'Skol',
        beerQuantity: Random().nextInt(200));
    final StockUpdate? createdStockUpdate =
        await StockUpdateWebClient().saveStockUpdate(newStockUpdate, '1000');

    expect(newStockUpdate.toJson(), createdStockUpdate!.toJson());
  });
}
