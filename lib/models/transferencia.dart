import 'package:bytebank/models/usuario.dart';

class Transferencia {
  final double valor;
  final Usuario conta;

  Transferencia(this.valor, this.conta);
}