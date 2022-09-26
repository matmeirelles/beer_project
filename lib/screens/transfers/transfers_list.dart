import 'package:beers_project/components/transfer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/transfer.dart';
import '../../model/transfers.dart';

const String _appBarTitle = 'Lista de transferências';

class TransfersList extends StatelessWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<Transfers>(builder: (context, transfers, child) {
        final List<Transfer> transfersList =
            transfers.transfersList.reversed.toList();
        return ListView.builder(
          itemCount: transfersList.length,
          itemBuilder: (BuildContext context, int index) {
            final transfer = transfersList[index];
            return TransferCard(
              transfer: transfer,
            );
          },
        );
      }),
    );
  }
}
