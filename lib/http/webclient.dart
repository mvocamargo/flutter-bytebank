import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.baseUrl}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transferencia>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response =
      await client.get('http://192.168.0.15:8080/transactions');
  final List<dynamic> decodeJson = jsonDecode(response.body);
  final List<Transferencia> transferencias = List();
  for (Map<String, dynamic> transferenciaJson in decodeJson) {
    final Map<String, dynamic> contactJson = transferenciaJson['contact'];
    final Transferencia transferencia =  Transferencia(
      transferenciaJson['valor'],
      Usuario(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transferencias.add(transferencia);
  }

  return transferencias;
}
