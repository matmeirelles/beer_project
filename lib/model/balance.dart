// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Balance extends ChangeNotifier {
  double totalValue;

  Balance({required this.totalValue});

  void addValue(double valueToAdd) {
    totalValue += valueToAdd;
    notifyListeners();
  }

  void reduceValue(double valueToReduce) {
    totalValue -= valueToReduce;
    notifyListeners();
  }

  @override
  String toString() => 'R\$ $totalValue';
}
