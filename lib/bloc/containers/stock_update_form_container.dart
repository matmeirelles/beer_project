import 'package:beers_project/components/bloc_container.dart';
import 'package:beers_project/screens/stock_update/stock_update_form_view.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/beer.dart';
import '../cubits/stock_update_form_cubit.dart';

class StockUpdateFormContainer extends BlocContainer {
  final Beer beer;
  const StockUpdateFormContainer({Key? key, required this.beer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return BlocProvider<StockUpdateFormCubit>(
      create: (context) {
        return StockUpdateFormCubit(dependencies: dependencies);
      },
      child: StockUpdateFormView(
        beer: beer,
      ),
    );
  }
}
