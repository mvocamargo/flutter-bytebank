import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDao {

  static const String _tableName = 'usuarios';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numeroConta = 'numero_conta';


  static const String tableSql = '''CREATE TABLE $_tableName(
        $_id INTEGER PRIMARY KEY, 
        $_nome TEXT, 
        $_numeroConta INTEGER)''';


  // salvar usuario
  Future<int> save(Usuario usuario) async{

    final Database db = await getDatabase();
    Map<String, dynamic> usuarioMap = _toMap(usuario);
    return db.insert(_tableName, usuarioMap);

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
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Usuario> usuarios = _toList(result);
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

  Future<int> update(Usuario usuario) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> usuarioMap = _toMap(usuario);
    return db.update(
      _tableName,
      usuarioMap,
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

    Map<String, dynamic> _toMap(Usuario usuario) {
    final Map<String, dynamic> usuarioMap = Map();
    usuarioMap[_nome] = usuario.nome;
    usuarioMap[_numeroConta] = usuario.numeroConta;
    return usuarioMap;
  }

  List<Usuario> _toList(List<Map<String, dynamic>> result) {
    final List<Usuario> usuarios = List();  
    for (Map<String, dynamic> item in result) {
      final Usuario usuario = Usuario(
        item[_id],
        item[_nome],
        item[_numeroConta],
      );
      usuarios.add(usuario);
    }
    return usuarios;
  }

}