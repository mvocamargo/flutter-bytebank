import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:bytebank/screens/usuarios/form.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Usuarios';

class ContatosLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Usuario>>(
        initialData: List(),
        future:  findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Usuario> usuarios = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Usuario usuario = usuarios[index];
                  return _UsuarioItem(usuario);
                },
                itemCount: usuarios.length,
              );
              break;
          }
          return Text('Erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContatoFormulario(),
                ),
              )
              .then(
                (novoContato) => debugPrint(novoContato.toString()),
              );
        },
      ),
    );
  }
}

class _UsuarioItem extends StatelessWidget {
  final Usuario usuario;

  _UsuarioItem(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          usuario.nome,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          usuario.numeroConta.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
