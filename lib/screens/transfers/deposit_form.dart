import 'package:beers_project/model/balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/text_input_editor.dart';
import '../../components/todo_snackbar.dart';

class DepositForm extends StatelessWidget {
  DepositForm({Key? key}) : super(key: key);

  final TextEditingController _addValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Deposito'),
      ),
      body: Column(
        children: [
          TextInputEditor(
            controller: _addValueController,
            icon: Icons.monetization_on,
            label: 'Valor para deposito',
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              if (_addValueController.text.isNotEmpty) {
                final double addValue = double.parse(_addValueController.text);
                Provider.of<Balance>(context, listen: false).addValue(addValue);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(showToDoSnackbar());
              }
            },
            child: const Text('Fazer deposito'),
          ),
        ],
      ),
    );
  }
}
