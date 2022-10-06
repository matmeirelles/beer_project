import 'package:beers_project/bloc/cubits/stock_update_list_cubit.dart';
import 'package:beers_project/components/centered_message.dart';
import 'package:beers_project/components/loading.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/stock_update_card.dart';

class StockUpdateListView extends StatelessWidget {
  const StockUpdateListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Atualização de estoque'),
      ),
      body: BlocBuilder<StockUpdateListCubit, StockUpdateListState>(
        builder: (context, state) {
          if (state is InitStockUpdateListState ||
              state is LoadingStockUpdateListState) {
            return const Loading();
          }
          if (state is LoadedStockUpdateListSate) {
            final stockUpdateList = state.stockUpdateList;
            if (stockUpdateList.isNotEmpty) {
              return ListView.builder(
                itemCount: stockUpdateList.length,
                itemBuilder: ((context, index) {
                  final StockUpdate stockUpdate = stockUpdateList[index];
                  return StockUpdateCard(
                    stockUpdate: stockUpdate,
                  );
                }),
              );
            }
            return const CenteredMessage(
              message: 'Não há nenhuma atualização de estoque',
              icon: Icons.warning,
              iconSize: 50.0,
            );
          }

          return const CenteredMessage(message: 'Unknow error');
        },
      ),
    );
  }
}
