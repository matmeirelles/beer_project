import 'package:flutter/material.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final IconData icon;
  final Color colorIcon;

  const ResponseDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    required this.colorIcon,
    this.buttonText = 'Confirm',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 64,
              color: colorIcon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: 'Sucesso',
      message: message,
      icon: Icons.done,
      colorIcon: Colors.green,
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String message;

  const FailureDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: 'Erro',
      message: message,
      icon: Icons.warning,
      colorIcon: Colors.red,
    );
  }
}
