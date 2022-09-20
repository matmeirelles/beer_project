import 'dart:async';

import 'package:beers_project/database/dao/beer_dao.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/screens/beers/beer_form.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/screens/brands/brand_form.dart';
import 'package:beers_project/screens/brands/brand_list.dart';
import 'package:beers_project/screens/dashboard.dart';
import 'package:beers_project/screens/stock_update/stock_update_list.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

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

  runZonedGuarded<Future<void>>(() async {
    runApp(MyApp(
        beerDao: BeerDao(), stockUpdateWebClient: StockUpdateWebClient()));
  },
      (error, stackTrace) =>
          FirebaseCrashlytics.instance.recordError(error, stackTrace));
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
        theme: ThemeData(
          primaryColor: Colors.yellow[800],
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.blueAccent,
          ),
        ),
        home: const Dashboard(),
        // initialRoute: '/beerList',
        routes: {
          '/beerList': (context) => const BeerList(),
          '/beerForm': (context) => BeerForm(),
          '/dashboard': (context) => const Dashboard(),
          '/brandList': (context) => const BrandList(),
          '/brandForm': (context) => BrandForm(),
          '/stockUpdateList': (context) => const StockUpdateList(),
          // '/stockUpdateForm': (context) => StockUpdateForm()),
        },
      ),
    );
  }
}
