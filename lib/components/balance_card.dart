import 'package:beers_project/components/app_card.dart';
import 'package:beers_project/model/balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Balance>(builder: ((
      context,
      balance,
      child,
    ) {
      return AppCard(
        title: balance.toString(),
        fontSize: 24.0,
        canDelete: false,
      );
    }));
  }
}
