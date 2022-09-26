import 'package:beers_project/components/app_card.dart';
import 'package:beers_project/screens/transfers/transfers_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/transfer_card.dart';
import '../../model/transfer.dart';
import '../../model/transfers.dart';

class LastTransfers extends StatelessWidget {
  const LastTransfers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Ultimas transferências',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Consumer<Transfers>(
            builder: (context, transfers, child) {
              final List<Transfer> transfersList = transfers.transfersList;
              final int listSize = transfersList.length;
              final List<Transfer> lastTransfers =
                  transfersList.reversed.toList();

              if (listSize == 0) {
                return const AppCard(
                  title: 'Você não possui nenhuma transferência.',
                  canDelete: false,
                );
              }

              return ListView.builder(
                itemCount: listSize < 2 ? listSize : 2,
                shrinkWrap: true,
                itemBuilder: ((context, index) =>
                    TransferCard(transfer: lastTransfers[index])),
              );
            },
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TransfersList())),
              child: const Text('Lista de transferências'))
        ],
      ),
    );
  }
}
