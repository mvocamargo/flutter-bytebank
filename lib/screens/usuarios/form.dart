import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Novo Contato';

const _rotuloConta = 'Número da Conta';
const _dicaConta = '0000-X';
const _rotuloNome = 'Nome do Usuário';
const _dicaNome = 'Insira seu nome';

const _textoBotaoConfirmar = 'Adicionar Usuário';

class ContatoFormulario extends StatefulWidget {

  @override
  _ContatoFormularioState createState() => _ContatoFormularioState();
}

class _ContatoFormularioState extends State<ContatoFormulario> {

  final TextEditingController _controllerFieldNome = TextEditingController();
  final TextEditingController _controllerFieldConta = TextEditingController();

  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _controllerFieldNome,
              rotulo: _rotuloNome,
              dica: _dicaNome,
              teclado: TextInputType.text,
            ),
            Editor(
              controller: _controllerFieldConta,
              rotulo: _rotuloConta,
              dica: _dicaConta,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text(_textoBotaoConfirmar),
                  onPressed: () {
                    final String nome = _controllerFieldNome.text;
                    final int numeroConta = int.tryParse(_controllerFieldConta.text);

                    final Usuario novoContato = Usuario(nome, numeroConta);

                    Navigator.pop(context, novoContato);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}