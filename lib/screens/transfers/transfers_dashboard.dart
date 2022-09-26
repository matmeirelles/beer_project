import 'package:beers_project/components/balance_card.dart';
import 'package:beers_project/screens/transfers/deposit_form.dart';
import 'package:beers_project/screens/transfers/last_transfers.dart';
import 'package:beers_project/screens/transfers/transfer_form.dart';
import 'package:beers_project/screens/transfers/transfers_list.dart';
import 'package:flutter/material.dart';

class TransfersDashboard extends StatelessWidget {
  const TransfersDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferência'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          const Align(
            alignment: Alignment.topCenter,
            child: BalanceCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DepositForm())),
                child: const Text('Fazer deposito'),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TransferForm())),
                  child: const Text('Fazer transferência')),
            ],
          ),
          LastTransfers(),
        ],
      ),
    );
  }
}
