import 'package:flutter/material.dart';

const stockUpdateAuthDialogTextFieldPasswordKey =
    Key('stockUpdateAuthDialogTextFieldPassword');

class StockUpdateAuthDialog extends StatelessWidget {
  final Function(String password) onConfirm;

  StockUpdateAuthDialog({Key? key, required this.onConfirm}) : super(key: key);

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Autenticação'),
      content: TextField(
        key: stockUpdateAuthDialogTextFieldPasswordKey,
        keyboardType: TextInputType.number,
        controller: _passwordController,
        maxLength: 4,
        obscureText: true,
        autofocus: true,
        showCursor: false,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 16,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
