import 'package:beers_project/database/app_database.dart';
import 'package:beers_project/model/beer.dart';
import 'package:sqflite/sqflite.dart';

class BeerDao {
  static const String createBeerTableSql =
      'CREATE TABLE $_beerTableName ($_id INTEGER PRIMARY KEY, $_beerName TEXT, $_beerBrand TEXT)';
  static const String _id = 'id';
  static const String _beerName = 'beer_name';
  static const String _beerBrand = 'beer_brand';
  static const String _beerTableName = 'beers';

  Future<Beer?> findUniqueBeer(int id) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> beerMapList = await db.query(
      _beerTableName,
      where: '$_id = ?',
      whereArgs: [_id],
      limit: 1,
    );

    if (beerMapList.isNotEmpty) {
      final Map<String, dynamic> beerMap = beerMapList[0];

      return _extractMapToBeer(beerMap);
    }

    return null;
  }

  Future<List<Beer>>? findAllBeers() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> beersMapList = await db.query(
      _beerTableName,
    );

    final List<Beer> beersList = [];
    for (Map<String, dynamic> beerMap in beersMapList) {
      final Beer beer = _extractMapToBeer(beerMap);
      beersList.add(beer);
    }
    return beersList;
  }

  Future<int>? saveBeer(Beer beer) async {
    final Database db = await getDatabase();

    Map<String, dynamic> beerMap = _extractBeerToMap(beer);

    return db.insert(_beerTableName, beerMap);
  }

  // Future<int> deleteBeer() async{}

  // Future<int> updateBeer() async{}

  Beer _extractMapToBeer(Map<String, dynamic> beerMap) {
    return Beer(
      id: beerMap[_id],
      beerName: beerMap[_beerName],
      beerBrand: beerMap[_beerBrand],
    );
  }

  Map<String, dynamic> _extractBeerToMap(Beer beer) {
    final Map<String, dynamic> beerMap = {
      _beerName: beer.beerName,
      _beerBrand: beer.beerBrand,
    };
    return beerMap;
  }
}
