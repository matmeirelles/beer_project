import 'package:beers_project/components/text_input_editor.dart';
import 'package:beers_project/model/transfer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/balance.dart';
import '../../model/transfers.dart';

const String _addTransfer = 'Nova transferência';
const String _accountNumberLabel = 'Numero da conta';
const String _valueLabel = 'Valor da transferência';
const String _makeTransfer = 'Adicionar transferência';

class TransferForm extends StatelessWidget {
  TransferForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_addTransfer),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          TextInputEditor(
            controller: _accountNumberController,
            label: _accountNumberLabel,
            keyboardType: TextInputType.number,
          ),
          TextInputEditor(
            controller: _valueController,
            label: _valueLabel,
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
              onPressed: () {
                final int? accountNumber =
                    int.tryParse(_accountNumberController.text);
                final double? value = double.tryParse(_valueController.text);

                final bool validFields =
                    _validateTransferFields(accountNumber, value);

                if (validFields) {
                  final bool balanceEnough = _validateBalance(context, value!);
                  if (balanceEnough) {
                    final Transfer newTransfer =
                        Transfer(accountNumber: accountNumber!, value: value);
                    _addAndTransferAndUpdateState(context, newTransfer, value);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Saldo insuficiente'),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Valores inválidos'),
                  ));
                }
              },
              child: const Text(_makeTransfer)),
        ],
      ),
    );
  }

  bool _validateTransferFields(int? accountNumber, double? value) {
    return accountNumber != null && value != null;
  }

  void _addAndTransferAndUpdateState(
    BuildContext context,
    Transfer newTransfer,
    double value,
  ) {
    Provider.of<Transfers>(context, listen: false).addTransfer(newTransfer);
    Provider.of<Balance>(context, listen: false).reduceValue(value);
  }

  bool _validateBalance(BuildContext context, double value) {
    return value <= Provider.of<Balance>(context, listen: false).totalValue;
  }
}
