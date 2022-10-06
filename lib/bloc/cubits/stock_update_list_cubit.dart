import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/stock_update.dart';

@immutable
abstract class StockUpdateListState {
  const StockUpdateListState();
}

@immutable
class InitStockUpdateListState extends StockUpdateListState {
  const InitStockUpdateListState();
}

@immutable
class LoadingStockUpdateListState extends StockUpdateListState {
  const LoadingStockUpdateListState();
}

@immutable
class LoadedStockUpdateListSate extends StockUpdateListState {
  final List<StockUpdate> stockUpdateList;

  const LoadedStockUpdateListSate(this.stockUpdateList);
}

@immutable
class FatalErrorStockUpdateListState extends StockUpdateListState {
  const FatalErrorStockUpdateListState();
}

class StockUpdateListCubit extends Cubit<StockUpdateListState> {
  StockUpdateListCubit() : super(const InitStockUpdateListState());

  void reload(StockUpdateWebClient webClient) async {
    emit(const LoadingStockUpdateListState());
    webClient.findAllStockUpdates().then(
        (stockUpdateList) => emit(LoadedStockUpdateListSate(stockUpdateList)));
  }
}
