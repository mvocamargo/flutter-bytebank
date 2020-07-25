import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/models/transferencia.dart';

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferência'),
      ),
      body: FutureBuilder<List<Transferencia>>(
        // Usando delay para testar o funcionamento do loading
        future: Future.delayed(Duration(seconds: 2)).then((value) => findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress(
                message: 'Carregando transferências',
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transferencia> transferencias = snapshot.data;
                if (transferencias.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transferencia transferencia = transferencias[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transferencia.valor.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transferencia.conta.numeroConta.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transferencias.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhuma transferência encontrada',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage('Erro desconhecido');
        },
      ),
    );
  }
}
