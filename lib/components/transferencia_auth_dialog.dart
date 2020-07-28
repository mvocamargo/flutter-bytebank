import 'package:flutter/material.dart';

class TransferenciaAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              print('opa');
            },
            child: Text('Cancelar')),
        FlatButton(
            onPressed: () {
              print('opa');
            },
            child: Text('Confirmar')),
      ],
    );
  }
}
