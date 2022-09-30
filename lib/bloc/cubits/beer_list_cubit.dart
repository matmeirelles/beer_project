import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/dao/beer_dao.dart';
import '../../screens/beers/beer_list.dart';

class BeerListCubit extends Cubit<BeerListState> {
  BeerListCubit() : super(const InitBeerListState());

  void reload(BeerDao beerDao) async {
    emit(const LoadingBeerListState());
    beerDao.findAllBeers()!.then((beers) => emit(LoadedBeerListState(beers)));
  }
}
