import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({Key? key, this.message = 'Loading'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: CircularProgressIndicator(),
          ),
          Text(message),
        ],
      ),
    );
  }
}
