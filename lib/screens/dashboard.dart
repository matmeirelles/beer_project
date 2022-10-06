// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beers_project/bloc/containers/name_container.dart';
import 'package:beers_project/bloc/containers/stock_update_list_container.dart';
import 'package:beers_project/components/bloc_container.dart';

import '../bloc/containers/beers_list_container.dart';
import '../bloc/cubits/name_cubit.dart';
import '../components/dashboard_feature_item.dart';
import '../components/localization.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewI18N(context);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
            builder: (context, state) => Text(
                  '${i18n.welcome} $state',
                )),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constrains.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/beer_image.jpeg'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      FeatureItem(
                          name: i18n.change_name,
                          icon: Icons.person_outlined,
                          onClick: () => _changeName(context)),
                      FeatureItem(
                        name: i18n.beers_text,
                        icon: Icons.sports_bar,
                        onClick: () => _pushToBeersList(context),
                      ),
                      FeatureItem(
                        name: i18n.brands_text,
                        icon: Icons.home_filled,
                        onClick: () => _goToPage(
                            context: context, routeName: '/brandList'),
                      ),
                      FeatureItem(
                        name: i18n.stock_update_text,
                        icon: Icons.description,
                        onClick: () => _pushToStockUpdateList(
                            context, const StockUpdateListContainer()),
                      ),
                      FeatureItem(
                        name: i18n.transfer_text,
                        icon: Icons.description,
                        onClick: () =>
                            _goToPage(context: context, routeName: '/transfer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pushToBeersList(BuildContext blocContext) {
    push(blocContext, const BeersListContainer());
  }

  void _goToPage({required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  void _changeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: const NameContainer(),
      ),
    ));
  }

  _pushToStockUpdateList(BuildContext blocContext, BlocContainer container) {
    push(blocContext, container);
  }
}
