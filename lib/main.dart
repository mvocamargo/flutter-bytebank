import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerFieldConta = TextEditingController();
  final TextEditingController _controllerFieldValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transfer'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            controller: _controllerFieldConta,
            rotulo: 'Número da Conta',
            dica: '0000',
          ),
          Editor(
            controller: _controllerFieldValor,
            rotulo: 'Valor',
            dica: '0000',
            icone: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text('Adicionar'),
            onPressed: () {
              _criaTransferencia(context);
            },
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    debugPrint('Add clicked');
    final String conta = _controllerFieldConta.text;
    final double valor = double.tryParse(_controllerFieldValor.text);
    if (conta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, conta);
      print('Criando Transferencia');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String rotulo;
  final String dica;
  final IconData icone;

  const Editor({this.controller, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  
  final List<Transferencia> _transferencias = List();
  
  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(100, '1000'));
    _transferencias.add(Transferencia(100, '1000'));
    _transferencias.add(Transferencia(100, '1000'));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice){

          return ItemTransferencia(_transferencias[indice]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context){
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida){
            print('opa future');
            print('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida);
          });
        },
      ),
    );
  }
}


class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.conta),
    ));
  }
}

class Transferencia {
  final double valor;
  final String conta;

  Transferencia(this.valor, this.conta);
}
