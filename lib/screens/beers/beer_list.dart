import 'package:beers_project/components/todo_snackbar.dart';
import 'package:beers_project/screens/stock_update/stock_update_form.dart';
import 'package:flutter/material.dart';

import '../../components/beer_card.dart';
import '../../model/beer.dart';
import '../../widgets/app_dependencies.dart';
import 'beer_form.dart';

const String _appBarTitle = 'Lista de cervejas';

class BeerList extends StatefulWidget {
  const BeerList({Key? key}) : super(key: key);

  @override
  State<BeerList> createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
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
      body: FutureBuilder<List<Beer>>(
        initialData: List.empty(),
        future: dependencies.beerDao.findAllBeers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;

            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: CircularProgressIndicator(),
                    ),
                    Text('Carregando dados'),
                  ],
                ),
              );

            case ConnectionState.active:
              // TODO: Handle this case.
              break;

            case ConnectionState.done:
              final List<Beer> beerList = snapshot.data as List<Beer>;
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

          await Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => BeerForm())));

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
