import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubits/current_locale_cubit.dart';

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get welcome => localize({'pt-br': 'Bem vindo', 'en': 'Welcome'});

  String get change_name =>
      localize({'pt-br': 'Mudar nome', 'en': 'Change name'});

  String get beers_text => localize({'pt-br': 'Cervejas', 'en': 'Beers'});

  String get brands_text => localize({'pt-br': 'Marcas', 'en': 'Brands'});

  String get stock_update_text =>
      localize({'pt-br': 'Atualização de estoque', 'en': 'Stock Update'});

  String get transfer_text =>
      localize({'pt-br': 'Transferir', 'en': 'Transfer'});
}

abstract class ViewI18N {
  late String _language;

  ViewI18N(BuildContext context) {
    _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> values) {
    return values[_language]!;
  }
}
