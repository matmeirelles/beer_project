import 'package:beers_project/model/transfer.dart';
import 'package:flutter/material.dart';

class Transfers extends ChangeNotifier {
  final List<Transfer> _transfers = List.empty(growable: true);

  List<Transfer> get transfersList => _transfers;

  void addTransfer(Transfer transfer) {
    _transfers.add(transfer);

    notifyListeners();
  }
}
