import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/bloc_container.dart';
import '../cubits/current_locale_cubit.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;
  const LocalizationContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: child,
    );
  }
}
