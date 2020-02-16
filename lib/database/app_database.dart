import 'package:bytebank/database/dao/usuario_dao.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Método que retorna um Future
Future<Database> getDatabase() async {

  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(UsuarioDao.tableSql);
  }, version: 1);

  // // Retorna o caminho do banco em uma Future
  // return getDatabasesPath().then((dbPath) {
  //   // Cria o arquivo de banco de dados no local retornado pelo getDatabasesPath() e adiciona o nome do arquivo do banco de dados que será usado pelo app
  //   final String path = join(dbPath, 'bytebank.db');
  //   // Instancia o banco de dados e cria a(s) tabelas(s) necessária(s) para a aplicação
  //   return openDatabase(path, onCreate: (db, version) {
  //     db.execute('CREATE TABLE usuarios('
  //         'id INTEGER PRIMARY KEY, '
  //         'nome TEXT, '
  //         'numero_conta INTEGER)');
  //   }, version: 1);
  // });
}

// salvar usuario
Future<int> save(Usuario usuario) async{

  final Database db = await getDatabase();
  final Map<String, dynamic> usuarioMap = Map();
  usuarioMap['nome'] = usuario.nome;
  usuarioMap['numero_conta'] = usuario.numeroConta;
  return db.insert('usuarios', usuarioMap);

  // return getDatabase().then((db) {
  //   final Map<String, dynamic> usuarioMap = Map();
  //   usuarioMap['nome'] = usuario.nome;
  //   usuarioMap['numero_conta'] = usuario.numeroConta;
  //   return db.insert('usuarios', usuarioMap);
  // });
}

// pegar todos os usuarios
Future<List<Usuario>> findAll() async {

  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('usuarios');
  final List<Usuario> usuarios = List();
  
  for (Map<String, dynamic> item in result) {
    final Usuario usuario = Usuario(
      item['id'],
      item['nome'],
      item['numero_conta'],
    );
    usuarios.add(usuario);
  }
  return usuarios;

  // return getDatabase().then((db) {
  //   return db.query('usuarios').then((maps) {
  //     final List<Usuario> usuarios = List();
  //     for (Map<String, dynamic> map in maps) {
  //       final Usuario usuario = Usuario(
  //         map['id'],
  //         map['nome'],
  //         map['numero_conta'],
  //       );
  //       usuarios.add(usuario);
  //     }
  //     return usuarios;
  //   });
  // });
}
