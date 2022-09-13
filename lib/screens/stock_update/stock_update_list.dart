import 'package:beers_project/components/centered_message.dart';
import 'package:beers_project/components/loading.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:flutter/material.dart';

import '../../components/stock_update_card.dart';

class StockUpdateList extends StatefulWidget {
  const StockUpdateList({Key? key}) : super(key: key);

  @override
  State<StockUpdateList> createState() => StockUpdateListState();
}

class StockUpdateListState extends State<StockUpdateList> {
  final StockUpdateWebClient _webClient = StockUpdateWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Atualização de estoque'),
      ),
      body: FutureBuilder<List<StockUpdate>>(
        future: _webClient.findAllStockUpdates(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // return const CenteredMessage(
              //   message: 'Erro',
              //   icon: Icons.warning,
              //   iconSize: 50.0,
              // );
              break;
            case ConnectionState.waiting:
              return const Loading();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final stockUpdates = snapshot.data as List<StockUpdate>;
              //TODO: Adicionar tratamento de erro quando nao houver retorno da API
              
              // if (snapshot.hasError) {
              //   print('AQUIIIII!!!!!');
              //   return const CenteredMessage(
              //     message: 'Erro',
              //     icon: Icons.warning,
              //     iconSize: 50.0,
              //   );
              // }

              if (stockUpdates.isNotEmpty) {
                return ListView.builder(
                  itemCount: stockUpdates.length,
                  itemBuilder: ((context, index) {
                    final StockUpdate stockUpdate = stockUpdates[index];
                    return StockUpdateCard(
                      stockUpdate: stockUpdate,
                    );
                  }),
                );
              }

              return const CenteredMessage(
                message: 'Lista vazia',
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
