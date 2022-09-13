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
}
