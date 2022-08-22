import 'package:flutter/material.dart';

import '../model/stock_update.dart';

class StockUpdateCard extends StatelessWidget {
  final StockUpdate stockUpdate;

  const StockUpdateCard({
    Key? key,
    required this.stockUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.description),
        title: Text('Cerveja: ${stockUpdate.beerName}'),
        subtitle: Text('Quantidade: ${stockUpdate.beerQuantity.toString()}'),
      ),
    );
  }
}
