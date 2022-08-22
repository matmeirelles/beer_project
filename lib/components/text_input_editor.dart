import 'package:flutter/material.dart';

class TextInputEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;

  const TextInputEditor({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
