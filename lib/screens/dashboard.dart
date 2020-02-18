import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:bytebank/screens/usuarios/lista.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _FeatureItem(
                  'Transferência',
                  Icons.monetization_on,
                  onClick: () => _exibeListaUsuarios(context),
                ),
                _FeatureItem(
                  'Feed Transações',
                  Icons.description,
                  onClick: () => _exibeFeedTransferencia(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exibeListaUsuarios(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContatosLista(),
    ));
  }

  void _exibeFeedTransferencia(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaTransferencia(),
    ));
  }
}

class _FeatureItem extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Function onClick;

  _FeatureItem(this.nome, this.icone, {@required this.onClick})
      : assert(icone != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            height: 100,
            width: 150,
            padding: EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icone,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text(
                  nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
