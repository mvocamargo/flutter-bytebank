import 'package:bytebank/components/editor.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'New transfer';

const _rotuloConta = 'Número da Conta';
const _dicaConta = '0000-X';
const _rotuloValor = 'Número da Conta';
const _dicaValor = '0000.0';

const _textoBotaoConfirmar = 'Adicionar';

class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  
  final TextEditingController _controllerFieldConta = TextEditingController();
  final TextEditingController _controllerFieldValor = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controller: _controllerFieldConta,
              rotulo: _rotuloConta,
              dica: _dicaConta,
            ),
            Editor(
              controller: _controllerFieldValor,
              rotulo: _rotuloValor,
              dica: _dicaValor,
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () {
                _criaTransferencia(context);
              },
            ),
          ],
        ),
      )
    );
  }

  void _criaTransferencia(BuildContext context) {
    // final String<Usuario> conta = _controllerFieldConta.text;
    // final double valor = double.tryParse(_controllerFieldValor.text);
    // if (conta != null && valor != null) {
    //   final transferenciaCriada = Transferencia(valor, conta);
    //   Navigator.pop(context, transferenciaCriada);
    // }
  }
}