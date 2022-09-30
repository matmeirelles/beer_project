import 'package:beers_project/bloc/cubits/beer_list_cubit.dart';
import 'package:beers_project/components/loading.dart';
import 'package:beers_project/components/todo_snackbar.dart';
import 'package:beers_project/screens/stock_update/stock_update_form.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/beer_card.dart';
import '../../model/beer.dart';
import 'beer_form.dart';

const String _appBarTitle = 'Lista de cervejas';

@immutable
abstract class BeerListState {
  const BeerListState();
}

@immutable
class InitBeerListState extends BeerListState {
  const InitBeerListState();
}

@immutable
class LoadingBeerListState extends BeerListState {
  const LoadingBeerListState();
}

@immutable
class LoadedBeerListState extends BeerListState {
  final List<Beer> _beers;
  const LoadedBeerListState(this._beers);
}

@immutable
class FatalErrorBeerListState extends BeerListState {
  const FatalErrorBeerListState();
}

class BeerList extends StatelessWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Busque pelo nome da cerveja',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(showToDoSnackbar());
              // await Navigator.pushNamed(context, '/beerForm');
            },
          ),
        ],
      ),
      body: BlocBuilder<BeerListCubit, BeerListState>(
        builder: (context, state) {
          if (state is InitBeerListState || state is LoadingBeerListState) {
            return const Loading();
          }
          if (state is LoadedBeerListState) {
            final List<Beer> beerList = state._beers;
            return ListView.builder(
              itemCount: beerList.length,
              itemBuilder: (BuildContext context, int index) {
                final beer = beerList[index];
                return BeerCard(
                  beer: beer,
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StockUpdateForm(
                              beer: beer,
                            ))));
                  },
                );
              },
            );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.pushNamed(context, '/beerForm');

          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => BeerForm())))
              .then((_) => update(context, dependencies));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void update(BuildContext context, AppDependencies dependencies) {
    context.read<BeerListCubit>().reload(dependencies.beerDao);
  }
}
