import 'package:beers_project/components/bloc_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/dashboard.dart';
import '../cubits/name_cubit.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NameCubit>(
      create: (_) => NameCubit(name: 'Mateus'),
      child: const DashboardView(),
    );
  }
}
