import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double? iconSize;

  const CenteredMessage(
      {Key? key, required this.message, this.icon, this.iconSize = 40.0})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
