import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

const String baseUrl = 'http://192.168.0.15:8080/transactions';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    // Importante setar um timeout para não consumir recursos do dispositivo do usuário "eternamente"
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(Transferencia transferencia, String password) async {
    final String transferenciaJson = jsonEncode(transferencia.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transferenciaJson,
    );

    return Transferencia.fromJson(jsonDecode(response.body));
  }
}
