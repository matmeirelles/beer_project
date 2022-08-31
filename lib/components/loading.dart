import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;
  final bool circular;

  const Loading({
    Key? key,
    this.message = 'Loading',
    this.circular = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: circular == true
                ? const CircularProgressIndicator()
                : const LinearProgressIndicator(),
          ),
          Text(message),
        ],
      ),
    );
  }
}
