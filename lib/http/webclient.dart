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

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.0.15:8080/transactions';

Future<List<Transferencia>> findAll() async {
  // Improtante setar um timeout para não consumir recursos do dispositivo do usuário "eternamente"
  final Response response =
      await client.get(baseUrl).timeout(Duration(seconds: 5));
  final List<dynamic> decodeJson = jsonDecode(response.body);
  final List<Transferencia> transferencias = List();
  for (Map<String, dynamic> transferenciaJson in decodeJson) {
    final Map<String, dynamic> contactJson = transferenciaJson['contact'];
    final Transferencia transferencia = Transferencia(
      transferenciaJson['value'],
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

Future<Transferencia> save(Transferencia transferencia) async {
  final Map<String, dynamic> transferenciaMap = {
    'value': transferencia.valor,
    'contact': {
      'name': transferencia.conta.nome,
      'accountNumber': transferencia.conta.numeroConta,
    }
  };
  final String transferenciaJson = jsonEncode(transferenciaMap);

  final Response response = await client.post(
    baseUrl,
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    },
    body: transferenciaJson,
  );

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transferencia(
    json['value'],
    Usuario(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
