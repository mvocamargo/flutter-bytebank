import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/usuario_dao.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:bytebank/screens/transferencia/formulario-2.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferência';

class ContatosLista extends StatefulWidget {
  @override
  _ContatosListaState createState() => _ContatosListaState();
}

class _ContatosListaState extends State<ContatosLista> {
  final UsuarioDao _dao = UsuarioDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Usuario>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress(
                message: 'Carregando usuários',
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Usuario> usuarios = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Usuario usuario = usuarios[index];
                  return _UsuarioItem(
                    usuario,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransferenciaFormulario(usuario),
                        ),
                      );
                    },
                  );
                },
                itemCount: usuarios.length,
              );
              break;
          }
          return Text('Erro desconhecido');
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //   ),
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => ContatoFormulario(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _UsuarioItem extends StatelessWidget {
  final Usuario usuario;
  final Function onClick;

  _UsuarioItem(
    this.usuario, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
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
