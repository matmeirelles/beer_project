import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:mockito/mockito.dart';

import '../../database/dao/beer_dao.dart';

class MockBeerDao extends Mock implements BeerDao {}

class MockStockUpdateWebClient extends Mock implements StockUpdateWebClient {}
