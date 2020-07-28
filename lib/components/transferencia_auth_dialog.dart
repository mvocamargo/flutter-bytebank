import 'package:flutter/material.dart';

class TransferenciaAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransferenciaAuthDialog({
    @required this.onConfirm,
  });

  @override
  _TransferenciaAuthDialogState createState() => _TransferenciaAuthDialogState();
}

class _TransferenciaAuthDialogState extends State<TransferenciaAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        controller: _passwordController,
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
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar')),
        FlatButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(context);
            },
            child: Text('Confirmar')),
      ],
    );
  }
}
