import 'package:beers_project/components/bloc_container.dart';
import 'package:beers_project/screens/beers/beer_list.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/beer_list_cubit.dart';

class BeersListContainer extends BlocContainer {
  const BeersListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return BlocProvider<BeerListCubit>(
        create: (context) {
          final beerListCubit = BeerListCubit();
          beerListCubit.reload(dependencies.beerDao);
          return beerListCubit;
        },
        child: const BeerList());
  }
}
