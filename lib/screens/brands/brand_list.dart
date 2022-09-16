import 'package:beers_project/components/brand_card.dart';
import 'package:beers_project/components/loading.dart';
import 'package:beers_project/database/dao/brand_dao.dart';
import 'package:flutter/material.dart';

import '../../model/brand.dart';

const String _appBarTitle = 'Lista de Marcas';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final BrandDao _brandDao = BrandDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Brand>>(
        initialData: List.empty(),
        future: Future.delayed(const Duration(milliseconds: 500))
            .then((value) => _brandDao.findAllBrands()),
        builder: (context, snapshot) {
          // Detecta caso o snapshot retorne erro
          // snapshot.error;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              //TODO: Casos onde precisamos incluir um CTA para acionar o Future
              break;
            case ConnectionState.waiting:
              return const Loading();
            case ConnectionState.active:
              //TODO: Casos onde o Future vem por partes, como em um download, por exemplo
              break;
            case ConnectionState.done:
              final List<Brand> brands = snapshot.data as List<Brand>;
              return ListView.builder(
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  final Brand brand = brands[index];
                  return BrandCard(
                    brand: brand,
                  );
                },
              );
          }
          return const Text('Unknow error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/brandForm')
              .then((newBrand) => setState(() {}));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: ((context) => BrandForm())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
