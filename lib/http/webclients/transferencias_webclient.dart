import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

const String baseUrl = 'http://192.168.0.15:8080/transactions';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    // Importante setar um timeout para não consumir recursos do dispositivo do usuário "eternamente"
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(
      Transferencia transferencia, String password) async {
    final String transferenciaJson = jsonEncode(transferencia.toJson());

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transferenciaJson,
    );

    if (response.statusCode == 200) {
      return Transferencia.fromJson(jsonDecode(response.body));
    }

    // _throwHttpError(response.statusCode);
    // throw HttpException(_getMessage(response.statusCode));
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }

    return 'Erro desconhecido';
  }

  // void _throwHttpError(int statusCode) =>
  //     throw Exception(_statusCodeResponses[statusCode]);

  static final Map<int, String> _statusCodeResponses = {
    400: 'Houve um erro no envio dos dados',
    401: 'Houve falha na autenticação',
    409: 'Transação já foi realizada',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
