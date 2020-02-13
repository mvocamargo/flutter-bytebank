class Usuario {
  final String nome;
  final int numeroConta;

  Usuario(
    this.nome,
    this.numeroConta,
  );



  @override
  String toString() => 'Usuario nome: $nome, numeroConta: $numeroConta';
}
