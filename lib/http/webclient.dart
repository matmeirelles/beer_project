import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

class WebClient {
  static final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  static const String baseUrl = '192.168.15.38:8080';
  static const String transactionsBasePath = '/transactions';

  static const Map<int, String> statusCodeResponse = {
    401: 'Senha incorreta',
    400: 'Informações inválidas',
    409: 'Atualização de estoque já existe',
  };

  static void throwHttpError(Response response) {
    throw Exception(_getExceptionMessage(response.statusCode));
  }

  static String? _getExceptionMessage(int statusCode) {
    if (statusCodeResponse.containsKey(statusCode)) {
      return statusCodeResponse[statusCode];
    }
    return 'Erro desconhecido';
  }
}
