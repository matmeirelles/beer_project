import 'package:beers_project/components/response_dialog.dart';
import 'package:beers_project/components/text_input_editor.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../components/stock_update_auth_dialog.dart';
import '../../model/beer.dart';

class StockUpdateForm extends StatelessWidget {
  final Beer beer;
  final TextEditingController _quantityController = TextEditingController();
  final StockUpdateWebClient _webClient = StockUpdateWebClient();
  final String stockUpdateId = const Uuid().v4();

  final String appBarTitle = 'Atualizar estoque';

  StockUpdateForm({Key? key, required this.beer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(stockUpdateId);
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                beer.beerName,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(beer.beerBrand,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: TextInputEditor(
                controller: _quantityController,
                label: 'Quantidade',
                icon: Icons.warehouse,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_quantityController.text.isNotEmpty) {
                    final StockUpdate stockUpdateCreated = StockUpdate(
                      id: stockUpdateId,
                      beerName: beer.beerName,
                      beerQuantity: int.parse(_quantityController.text),
                    );
                    showDialog(
                      context: context,
                      builder: ((contextDialog) {
                        return StockUpdateAuthDialog(onConfirm: ((password) {
                          _saveStockUpdate(
                              stockUpdateCreated, password, context);
                        }));
                      }),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Preencha o campo "Quantidade')));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveStockUpdate(
    StockUpdate stockUpdateCreated,
    String password,
    BuildContext context,
  ) {
    _webClient
        .saveStockUpdate(stockUpdateCreated, password)
        .then((newStockUpdate) => showDialog(
            context: context,
            builder: (contextDialog) {
              return const SuccessDialog(
                  message: 'Atualização realizada com sucesso');
            }).then((value) => Navigator.pop(context)))
        .catchError((e) {
      if (e.message != null) {
        showDialog(
            context: context,
            builder: (contextDialog) {
              return FailureDialog(message: e.message);
            });
      } else {
        showDialog(
            context: context,
            builder: (contextDialog) {
              return const FailureDialog(message: 'Erro desconhecido');
            });
      }
    });
  }
}
