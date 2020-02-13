import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase(){
  // Retorna o caminho do banco em uma Future
  getDatabasesPath().then((dbPath){
    // Cria o arquivo de banco de dados no local retornado pelo getDatabasesPath() e adiciona o nome do arquivo do banco de dados que será usado pelo app
    final String path = join(dbPath, 'bytebank.db');
    // Instancia o banco de dados e cria a(s) tabelas(s) necessária(s) para a aplicação
    openDatabase(path, onCreate: (db, version){
      db.execute('CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)');
    }, version: 1);
  });
}