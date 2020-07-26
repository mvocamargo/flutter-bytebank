import 'package:bytebank/models/usuario.dart';

class Transferencia {
  final double valor;
  final Usuario conta;

  Transferencia(this.valor, this.conta);

  Transferencia.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        conta = Usuario.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': valor,
        'contact': conta.toJson(),
      };
}
