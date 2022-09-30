import 'package:flutter/material.dart';

abstract class BlocContainer extends StatelessWidget {
  const BlocContainer({super.key});
}

void push(BuildContext blocContext, BlocContainer container) {
  Navigator.of(blocContext).push(MaterialPageRoute(
    builder: (_) => container,
  ));
}
