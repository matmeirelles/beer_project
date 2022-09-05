import 'dart:convert';

import 'package:http/http.dart';

import '../../model/stock_update.dart';
import '../webclient.dart';

class StockUpdateWebClient {
  Future<List<StockUpdate>> findAllStockUpdates() async {
    final Response response = await WebClient.client
        .get(Uri.http(WebClient.baseUrl, WebClient.transactionsBasePath))
        .timeout(const Duration(seconds: 5));

    //No exemplo estou transformando os dados de Transactions da API em uma lista de StockUdpates apenas para teste
    return _jsonToStockUpdateList(response);
  }

  Future<StockUpdate> saveStockUpdate(
      StockUpdate stockUpdate, String password) async {
    final String transactionJson = jsonEncode(stockUpdate.toJson());

    //testando quando há atraso na requisição
    await Future.delayed(const Duration(seconds: 4));

    final Response response = await WebClient.client
        .post(Uri.http(WebClient.baseUrl, WebClient.transactionsBasePath),
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);

    if (response.statusCode != 200) {
      WebClient.throwHttpError(response);
    }

    return StockUpdate.fromJson(jsonDecode(response.body));
  }
}

List<StockUpdate> _jsonToStockUpdateList(Response response) {
  final List<dynamic> decodedStockUpdates = jsonDecode(response.body);

  return decodedStockUpdates
      .map((dynamic jsonElement) => StockUpdate.fromJson(jsonElement))
      .toList();
}
