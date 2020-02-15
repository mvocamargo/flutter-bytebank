class Usuario {
  final int id;
  final String nome;
  final int numeroConta;

  Usuario(
    this.id,
    this.nome,
    this.numeroConta,
  );


  @override
  String toString() => 'Usuario id: $id, nome: $nome, numeroConta: $numeroConta';
}
