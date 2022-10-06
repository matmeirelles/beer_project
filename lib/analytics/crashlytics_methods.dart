import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../model/stock_update.dart';

void sendErrorCrashlytics(error, StockUpdate stockUpdateCreated) {
  if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    FirebaseCrashlytics.instance.setCustomKey('exception', error.toString());
    FirebaseCrashlytics.instance
        .setCustomKey('http_body', stockUpdateCreated.toString());
    FirebaseCrashlytics.instance
        .setCustomKey('stock_update_id', stockUpdateCreated.id);
    FirebaseCrashlytics.instance.recordError(error, null);
  }
}
