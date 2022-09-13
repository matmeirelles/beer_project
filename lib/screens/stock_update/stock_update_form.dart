import 'dart:async';

import 'package:beers_project/components/loading.dart';
import 'package:beers_project/components/response_dialog.dart';
import 'package:beers_project/components/text_input_editor.dart';
import 'package:beers_project/http/webclients/stock_update_webclient.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../components/stock_update_auth_dialog.dart';
import '../../model/beer.dart';

class StockUpdateForm extends StatefulWidget {
  final Beer beer;

  const StockUpdateForm({Key? key, required this.beer}) : super(key: key);

  @override
  State<StockUpdateForm> createState() => _StockUpdateFormState();
}

class _StockUpdateFormState extends State<StockUpdateForm> {
  final TextEditingController _quantityController = TextEditingController();
  final StockUpdateWebClient _webClient = StockUpdateWebClient();
  final String stockUpdateId = const Uuid().v4();
  final String appBarTitle = 'Atualizar estoque';
  bool _loadingVisibility = false;

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
                widget.beer.beerName,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(widget.beer.beerBrand,
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
                onPressed: _loadingVisibility == true
                    ? null
                    : () {
                        if (_quantityController.text.isNotEmpty) {
                          final StockUpdate stockUpdateCreated = StockUpdate(
                            id: stockUpdateId,
                            beerName: widget.beer.beerName,
                            beerQuantity: int.parse(_quantityController.text),
                          );
                          showDialog(
                            context: context,
                            builder: ((contextDialog) {
                              return StockUpdateAuthDialog(
                                  onConfirm: ((password) {
                                _saveStockUpdate(
                                    stockUpdateCreated, password, context);
                              }));
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Preencha o campo "Quantidade')));
                        }
                      },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: _loadingVisibility == true
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Loading(
                          message: 'Enviando',
                          circular: false,
                        ),
                      )
                    : const Text('Salvar'),
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
    setState(() {
      _loadingVisibility = true;
    });
    _webClient.saveStockUpdate(stockUpdateCreated, password).whenComplete(() {
      setState(() {
        _loadingVisibility = false;
      });
    }).then((newStockUpdate) {
      return showDialog(
          context: context,
          builder: (contextDialog) {
            return const SuccessDialog(
                message: 'Atualização realizada com sucesso');
          }).then((value) => Navigator.pop(context));
    }).catchError((error) {
      _sendErrorCrashlytics(error, stockUpdateCreated);

      showDialog(
          context: context,
          builder: (contextDialog) {
            return const FailureDialog(message: 'Erro de timeout');
          });
    }, test: (error) => error is TimeoutException).catchError((error) {
      _sendErrorCrashlytics(error, stockUpdateCreated);

      if (error.message != null) {
        showDialog(
            context: context,
            builder: (contextDialog) {
              return FailureDialog(message: error.message);
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

  void _sendErrorCrashlytics(error, StockUpdate stockUpdateCreated) {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      FirebaseCrashlytics.instance.setCustomKey('exception', error.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('http_body', stockUpdateCreated.toString());
      FirebaseCrashlytics.instance
          .setCustomKey('stock_update_id', stockUpdateCreated.id);
      FirebaseCrashlytics.instance.recordError(error, null);
    }
  }
}
