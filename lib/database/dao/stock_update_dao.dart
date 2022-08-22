import 'package:beers_project/database/app_database.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:sqflite/sqflite.dart';

class StockUpdateDao {
  static const String createStockUpdateTableSql =
      'CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY, $_beerName TEXT, $_quantity INTEGER)';
  static const String _tableName = 'stock_update';
  static const String _id = 'id';
  static const String _beerName = 'beer_name';
  static const String _quantity = 'quantity';

  Future<List<StockUpdate>> findAllStockUpdates() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> stockUpdateMaps = await db.query(
      _tableName,
    );

    return _mapToStockUpdateList(stockUpdateMaps);
  }

  Future<int> saveStockUpdate(StockUpdate newStockUpdate) async {
    final Database db = await getDatabase();

    Map<String, dynamic> stockUpdateMap = _stockUpdateToMap(newStockUpdate);

    return db.insert(_tableName, stockUpdateMap);
  }

  Map<String, dynamic> _stockUpdateToMap(StockUpdate newStockUpdate) {
    Map<String, dynamic> stockUpdateMap = {};

    stockUpdateMap[_id] = newStockUpdate.id;
    stockUpdateMap[_beerName] = newStockUpdate.beerName;
    stockUpdateMap[_quantity] = newStockUpdate.beerQuantity;
    return stockUpdateMap;
  }

  List<StockUpdate> _mapToStockUpdateList(
      List<Map<String, dynamic>> stockUpdateMaps) {
    final List<StockUpdate> stockUpdates = [];

    for (Map<String, dynamic> map in stockUpdateMaps) {
      final StockUpdate stockUpdate = StockUpdate(
        id: map[_id],
        beerName: map[_beerName],
        beerQuantity: map[_id],
      );
      stockUpdates.add(stockUpdate);
    }
    return stockUpdates;
  }
}
