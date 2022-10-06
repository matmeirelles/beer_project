import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bloc_container.dart';
import '../../screens/stock_update/stock_update_list_view.dart';
import '../cubits/stock_update_list_cubit.dart';

class StockUpdateListContainer extends BlocContainer {
  const StockUpdateListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return BlocProvider<StockUpdateListCubit>(
      create: (context) {
        final stockUpdateListCubit = StockUpdateListCubit();
        stockUpdateListCubit.reload(dependencies.stockUpdateWebClient);
        return stockUpdateListCubit;
      },
      child: const StockUpdateListView(),
    );
  }
}
