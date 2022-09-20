import 'package:flutter/material.dart';

const stockUpdateAuthDialogTextFieldPasswordKey =
    Key('stockUpdateAuthDialogTextFieldPassword');

class StockUpdateAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  const StockUpdateAuthDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<StockUpdateAuthDialog> createState() => _StockUpdateAuthDialogState();
}

class _StockUpdateAuthDialogState extends State<StockUpdateAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: stockUpdateAuthDialogTextFieldPasswordKey,
      title: const Text('Autenticação'),
      content: TextField(
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
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
