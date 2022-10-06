import 'dart:async';

import 'package:beers_project/components/bloc_container.dart';
import 'package:beers_project/database/dao/beer_dao.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/model/balance.dart';
import 'package:beers_project/model/transfers.dart';
import 'package:beers_project/screens/beers/beer_form.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/screens/brands/brand_form.dart';
import 'package:beers_project/screens/brands/brand_list.dart';
import 'package:beers_project/screens/counter/counter.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:beers_project/screens/namer/namer.dart';
import 'package:beers_project/screens/stock_update/stock_update_list_view.dart';
import 'package:beers_project/screens/transfers/transfers_dashboard.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/containers/dashboard_container.dart';
import 'bloc/containers/localization_container.dart';
import 'components/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Desliga o envio de erros ao Crashlytics caso código esteja no modo debug
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('1234');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runApp(MyApp(
    beerDao: BeerDao(),
    stockUpdateWebClient: StockUpdateWebClient(),
  ));

  // runZonedGuarded<Future<void>>(() async {
  //   runApp(MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => Balance(totalValue: 0.0)),
  //       ChangeNotifierProvider(create: (context) => Transfers()),
  //     ],
  //     child: MyApp(
  //         beerDao: BeerDao(), stockUpdateWebClient: StockUpdateWebClient()),
  //   ));
  // },
  //     (error, stackTrace) =>
  //         FirebaseCrashlytics.instance.recordError(error, stackTrace));
}

class MyApp extends StatelessWidget {
  final BeerDao beerDao;
  final StockUpdateWebClient stockUpdateWebClient;

  const MyApp({
    Key? key,
    required this.beerDao,
    required this.stockUpdateWebClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      stockUpdateWebClient: stockUpdateWebClient,
      beerDao: beerDao,
      child: MaterialApp(
        theme: appTheme,
        home: const LocalizationContainer(
          child: DashboardContainer(),
        ),
        // initialRoute: '/beerList',
        routes: {
          '/beerList': (context) => const BeerListView(),
          '/beerForm': (context) => BeerForm(),
          '/dashboard': (context) => const DashboardContainer(),
          '/brandList': (context) => const BrandList(),
          '/brandForm': (context) => BrandForm(),
          '/stockUpdateList': (context) => const StockUpdateListView(),
          '/transfer': (context) => const TransfersDashboard(),
          // '/stockUpdateForm': (context) => StockUpdateForm()),
        },
      ),
    );
  }
}
