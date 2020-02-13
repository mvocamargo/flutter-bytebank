import 'package:bytebank/screens/usuarios/form.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Contacts';

class Contatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                'Gabbs',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                '1000',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
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
