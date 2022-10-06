import 'dart:async';

import 'package:beers_project/model/stock_update.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../analytics/crashlytics_methods.dart';

@immutable
abstract class StockUpdateFormState {
  const StockUpdateFormState();
}

@immutable
class InitStockUpdateFormState extends StockUpdateFormState {
  const InitStockUpdateFormState();
}

@immutable
class LoadingStockUpdateFormState extends StockUpdateFormState {
  const LoadingStockUpdateFormState();
}

@immutable
class SentState extends StockUpdateFormState {
  const SentState();
}

@immutable
class FatalErrorStockUpdateFormState extends StockUpdateFormState {
  final String message;
  const FatalErrorStockUpdateFormState({required this.message});
}

class StockUpdateFormCubit extends Cubit<StockUpdateFormState> {
  final AppDependencies dependencies;
  StockUpdateFormCubit({required this.dependencies})
      : super(const InitStockUpdateFormState());

  void saveStockUpdate(
    StockUpdate stockUpdateCreated,
    String password,
    BuildContext context,
    StockUpdateWebClient stockUpdateWebClient,
  ) {
    emit(const LoadingStockUpdateFormState());

    dependencies.stockUpdateWebClient
        .saveStockUpdate(stockUpdateCreated, password)!
        .then((newStockUpdate) => emit(const SentState()))
        .catchError(
      (error) {
        sendErrorCrashlytics(error, stockUpdateCreated);
        emit(const FatalErrorStockUpdateFormState(
            message: 'Não foi possível conectar ao servidor'));
      },
      test: (error) => error is TimeoutException,
    ).catchError(
      (error) {
        sendErrorCrashlytics(error, stockUpdateCreated);

        if (error.message != null) {
          emit(FatalErrorStockUpdateFormState(message: error.message));
        } else {
          emit(const FatalErrorStockUpdateFormState(
              message: 'Erro desconhecido'));
        }
      },
    );
  }
}
