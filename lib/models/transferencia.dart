import 'package:bytebank/models/usuario.dart';

class Transferencia {
  final String id;
  final double valor;
  final Usuario conta;

  Transferencia(this.valor, this.conta, this.id);

  Transferencia.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        conta = Usuario.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': valor,
        'contact': conta.toJson(),
      };
}
