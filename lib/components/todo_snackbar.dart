import 'package:flutter/material.dart';

SnackBar showToDoSnackbar() {
  return const SnackBar(
    content: Text('TODO'),
    duration: Duration(milliseconds: 500),
  );
}
