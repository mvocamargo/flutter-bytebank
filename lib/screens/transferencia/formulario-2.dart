import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transferencia_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencias_webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransferenciaFormulario extends StatefulWidget {
  final Usuario usuario;

  TransferenciaFormulario(this.usuario);

  @override
  _TransferenciaFormularioState createState() =>
      _TransferenciaFormularioState();
}

class _TransferenciaFormularioState extends State<TransferenciaFormulario> {
  final TextEditingController _valueController = TextEditingController();
  final TransferenciaWebClient _webClient = TransferenciaWebClient();
  final String transactionId = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print('ID da transferencia $transactionId');
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
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Enviando...',
                  ),
                ),
                visible: _sending,
              ),
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
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferência'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transferenciaCriada =
                          Transferencia(value, widget.usuario, transactionId);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransferenciaAuthDialog(
                              onConfirm: (String password) {
                                // debugPrint(context);
                                _save(transferenciaCriada, password, context);
                              },
                            );
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

  void _save(
    Transferencia transferenciaCriada,
    String password,
    BuildContext contextDialog,
  ) async {
    setState(() {
      _sending = true;
    });
    final Transferencia transferencia =
        await _webClient.save(transferenciaCriada, password).catchError((e) {
      showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog('Tempo de resposta excedido');
        },
      );
    }, test: (e) => e is TimeoutException).catchError((e) {
      showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(e.message);
        },
      );
    }, test: (e) => e is HttpException).catchError((e) {
      showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog('Erro desconhecido');
        },
      );
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    if (transferencia != null) {
      await showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog('Deu certo!!!');
        },
      );
      Navigator.pop(contextDialog);
    }
  }
}
