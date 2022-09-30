import 'package:flutter/material.dart';

import '../../components/text_input_editor.dart';
import '../../model/beer.dart';
import '../../widgets/app_dependencies.dart';

const String _appBarTitle = 'Nova cerveja';
const String _beerName = 'Nome da cerveja';
const String _beerBrand = 'Marca da cerveja';
const String _formError = 'Insira as informações da cerveja';
const String _addButton = 'Adicionar';

class BeerForm extends StatelessWidget {
  BeerForm({Key? key}) : super(key: key);

  final TextEditingController _beerNameController = TextEditingController();
  final TextEditingController _beerBrandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          TextInputEditor(
              controller: _beerNameController,
              label: _beerName,
              icon: Icons.sports_bar),
          TextInputEditor(
              controller: _beerBrandController,
              label: _beerBrand,
              icon: Icons.home_filled),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                if (_beerNameController.text.isNotEmpty &&
                    _beerBrandController.text.isNotEmpty) {
                  final Beer newBeer = Beer(
                    beerName: _beerNameController.text,
                    beerBrand: _beerBrandController.text,
                  );
                  dependencies.beerDao.saveBeer(newBeer);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      _formError,
                    ),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ));
                }
              },
              child: const Text(_addButton),
            ),
          )
        ],
      ),
    );
  }
}
