import 'package:bytebank/models/usuario.dart';
import 'package:bytebank/screens/usuarios/form.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Usuarios';

class ContatosLista extends StatelessWidget {

  final List<Usuario> usuarios = List();

  @override
  Widget build(BuildContext context) {
    usuarios.add(Usuario(1, 'marcus camargo', 2000));
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          final Usuario usuario = usuarios[index];
          return _UsuarioItem(usuario);
        },
        itemCount: usuarios.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(
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