import 'package:beers_project/components/text_input_editor.dart';
import 'package:beers_project/database/dao/brand_dao.dart';
import 'package:beers_project/model/brand.dart';
import 'package:flutter/material.dart';

class BrandForm extends StatelessWidget {
  BrandForm({Key? key}) : super(key: key);

  final String _appBarTitle = 'Nova marca';
  final String _brandNameLabel = 'Nome da marca';
  final String _brandCityLabel = 'Nome da cidade';
  final String _addButtonTitle = 'Adicionar';
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _brandCityController = TextEditingController();

  final BrandDao _brandDao = BrandDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextInputEditor(
              controller: _brandNameController,
              label: _brandNameLabel,
              icon: Icons.home_filled,
            ),
            TextInputEditor(
              controller: _brandCityController,
              label: _brandCityLabel,
              icon: Icons.location_city,
            ),
            ElevatedButton(
              onPressed: () {
                if (_brandNameController.text.isNotEmpty &&
                    _brandCityController.text.isNotEmpty) {
                  Brand newBrand = Brand(
                    brandName: _brandNameController.text,
                    brandCity: _brandCityController.text,
                  );
                  _brandDao.saveBrand(newBrand).then(
                        (id) => Navigator.pop(context, newBrand),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Insira o nome da marca'),
                  ));
                }
              },
              child: Text(_addButtonTitle),
            )
          ],
        ),
      ),
    );
  }
}
