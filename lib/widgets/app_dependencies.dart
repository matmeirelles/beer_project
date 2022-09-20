import 'package:beers_project/database/dao/beer_dao.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final BeerDao beerDao;
  final StockUpdateWebClient stockUpdateWebClient;

  const AppDependencies({
    Key? key,
    required Widget child,
    required this.beerDao,
    required this.stockUpdateWebClient,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return beerDao != oldWidget.beerDao ||
        stockUpdateWebClient != oldWidget.stockUpdateWebClient;
  }

  static AppDependencies of(BuildContext context) {
    final AppDependencies? result =
        context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'Nao foi encontrado o AppDependencies');
    return result!;
  }
}
