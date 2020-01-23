import 'package:flutter/material.dart';

const _tituloTela = 'Dashboard';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloTela),
      ),
    );
  }
}