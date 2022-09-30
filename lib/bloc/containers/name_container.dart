import 'package:beers_project/components/bloc_container.dart';
import 'package:beers_project/screens/namer/namer.dart';
import 'package:flutter/material.dart';

class NameContainer extends BlocContainer {
  const NameContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}
