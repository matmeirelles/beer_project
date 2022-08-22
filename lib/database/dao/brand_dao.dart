import 'package:sqflite/sqflite.dart';

import '../../model/brand.dart';
import '../app_database.dart';

class BrandDao {
  static const String createBrandTableSql =
      'CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY, $_brandName TEXT, $_brandCity TEXT)';
  static const String _tableName = 'brands';
  static const String _id = 'id';
  static const String _brandName = 'brand_name';
  static const String _brandCity = 'brand_city';

//CRUD
  Future<int> saveBrand(Brand brand) async {
    final Database db = await getDatabase();
    Map<String, dynamic> brandMap = _brandToMap(brand);

    return db.insert(_tableName, brandMap);
  }

  Future<int?> deleteBrand(int id) async {
    final Database db = await getDatabase();
    final Brand? brand = await findUniqueBrand(id);

    return brand != null
        ? db.delete(
            _tableName,
            where: '$_id = ?',
            whereArgs: [brand.id],
          )
        : null;
  }

  Future<int?> updateBrand(int id) async {
    final Database db = await getDatabase();
    final Brand? brand = await findUniqueBrand(id);

    if (brand != null) {
      final Map<String, dynamic> brandMap = _brandToMap(brand);
      return db.update(
        _tableName,
        brandMap,
        where: '$_id = ?',
        whereArgs: [_id],
      );
    }

    return null;
  }

  Future<Brand?> findUniqueBrand(int? id) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );

    return _extractUniqueMapToBrand(result);
  }

  Future<List<Brand>> findAllBrands() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return _toList(result);
  }

//Funções de apoio
  Map<String, dynamic> _brandToMap(Brand brand) {
    final Map<String, dynamic> brandMap = {};

    brandMap[_brandName] = brand.brandName;
    brandMap[_brandCity] = brand.brandCity;

    return brandMap;
  }

  List<Brand> _toList(List<Map<String, dynamic>> result) {
    final List<Brand> brands = [];

    for (Map<String, dynamic> row in result) {
      final Brand brand = Brand(
        id: row[_id],
        brandName: row[_brandName],
        brandCity: row[_brandCity],
      );
      brands.add(brand);
    }
    return brands;
  }

  Brand? _extractUniqueMapToBrand(List<Map<String, dynamic>> result) {
    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result[0];

      return Brand(
        id: map[_id],
        brandName: map[_brandName],
        brandCity: map[_brandCity],
      );
    }

    return null;
  }
}
