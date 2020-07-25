import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:flutter/material.dart';

class TransferenciaFormulario extends StatefulWidget {
  final Usuario usuario;

  TransferenciaFormulario(this.usuario);

  @override
  _TransferenciaFormularioState createState() => _TransferenciaFormularioState();
}

class _TransferenciaFormularioState extends State<TransferenciaFormulario> {
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.usuario.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.usuario.numeroConta.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferência'), onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transferenciaCriada = Transferencia(value, widget.usuario);
                      save(transferenciaCriada).then((transferenciaRecebida) {
                        if(transferenciaRecebida != null) {
                          Navigator.pop(context);
                        }
                      });
                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
