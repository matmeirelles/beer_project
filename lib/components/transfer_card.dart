import 'package:beers_project/components/app_card.dart';
import 'package:beers_project/model/transfer.dart';
import 'package:flutter/material.dart';

class TransferCard extends StatelessWidget {
  final Transfer transfer;

  const TransferCard({
    Key? key,
    required this.transfer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: transfer.value.toString(),
      subtitle: transfer.accountNumber.toString(),
      canDelete: false,
      fontSize: 24,
      icon: Icons.monetization_on,
    );
  }
}
