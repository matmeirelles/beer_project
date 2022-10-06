import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/dao/beer_dao.dart';
import '../../model/beer.dart';

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
  final List<Beer> beers;
  const LoadedBeerListState(this.beers);
}

@immutable
class FatalErrorBeerListState extends BeerListState {
  const FatalErrorBeerListState();
}

class BeerListCubit extends Cubit<BeerListState> {
  BeerListCubit() : super(const InitBeerListState());

  void reload(BeerDao beerDao) async {
    emit(const LoadingBeerListState());
    beerDao.findAllBeers()!.then((beers) => emit(LoadedBeerListState(beers)));
  }
}
