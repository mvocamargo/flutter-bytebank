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

  Usuario.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    nome = json['name'],
    numeroConta = json['accountNumber'];

  Map<String, dynamic> toJson() => {
    'name' : nome,
    'accountNumber' : numeroConta,
  };
}
