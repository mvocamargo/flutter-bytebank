import 'package:flutter/material.dart';

const _tituloTela = 'Dashboard';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloTela),
      ),
      body: Column(
        children: <Widget>[
          Image.asset('images/bytebank_logo.png'),
          Container(
            height: 120,
            color: Colors.green,
            child: Column(
              children: <Widget>[
                Icon(Icons.people),
                Text('Contacts'),
              ],
            ),
          )
        ],
      ),
    );
  }
}