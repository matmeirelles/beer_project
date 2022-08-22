import 'package:beers_project/database/dao/beer_dao.dart';
import 'package:beers_project/database/dao/brand_dao.dart';
import 'package:beers_project/database/dao/stock_update_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'beer.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(BrandDao.createBrandTableSql);
      db.execute(BeerDao.createBeerTableSql);
      db.execute(StockUpdateDao.createStockUpdateTableSql);
    },
    version: 1,
    // Fazer a limpeza do código. LEMBRAR DE ALTERAR A VERSÃO PARA A 2
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
