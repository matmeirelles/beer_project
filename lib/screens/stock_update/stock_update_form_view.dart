import 'package:beers_project/bloc/cubits/stock_update_form_cubit.dart';
import 'package:beers_project/components/loading.dart';
import 'package:beers_project/components/response_dialog.dart';
import 'package:beers_project/components/text_input_editor.dart';
import 'package:beers_project/model/stock_update.dart';
import 'package:beers_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../components/stock_update_auth_dialog.dart';
import '../../model/beer.dart';

class StockUpdateFormView extends StatelessWidget {
  final Beer beer;

  StockUpdateFormView({Key? key, required this.beer}) : super(key: key);

  final TextEditingController _quantityController = TextEditingController();
  final String stockUpdateId = const Uuid().v4();
  final String appBarTitle = 'Atualizar estoque';

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
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
              child: BlocConsumer<StockUpdateFormCubit, StockUpdateFormState>(
                listener: (context, state) {
                  if (state is SentState) {
                    showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return const SuccessDialog(
                            message: 'Atualização realizada com sucesso');
                      },
                    ).then((_) => Navigator.pop(context));
                  }
                  if (state is FatalErrorStockUpdateFormState) {
                    showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return FailureDialog(message: state.message);
                      },
                    );
                  }
                },
                builder: (context, state) => ElevatedButton(
                  onPressed: state is LoadingStockUpdateFormState
                      ? null
                      : () {
                          if (_quantityController.text.isNotEmpty) {
                            final StockUpdate stockUpdateCreated = StockUpdate(
                              id: stockUpdateId,
                              beerName: beer.beerName,
                              beerQuantity: int.parse(_quantityController.text),
                            );
                            showDialog(
                              context: context,
                              builder: ((_) {
                                return StockUpdateAuthDialog(
                                    onConfirm: ((password) {
                                  BlocProvider.of<StockUpdateFormCubit>(context)
                                      .saveStockUpdate(
                                          stockUpdateCreated,
                                          password,
                                          context,
                                          dependencies.stockUpdateWebClient);
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
                  child: state is LoadingStockUpdateFormState
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
            ),
          ],
        ),
      ),
    );
  }
}

SnackBar _showFailureMessage({String message = 'Erro ao realizar operação'}) {
  return SnackBar(content: Text(message));
}
