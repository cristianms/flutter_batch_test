import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_batch_test/helpers/database_helper.dart';
import 'package:flutter_batch_test/models/contato.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textoLog = '';
  int idAutoIncrement = 1;
  final qtdTeste = 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batch Test'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: _limpaTabela,
                  child: Text('Limpa tabela'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: _insereNormal,
                  child: Text('Insere normal'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: _insereBatch,
                  child: Text('Insere via batch'),
                ),
              ),
              // Container de logs
              Expanded(
                child: Container(
                  color: Colors.black12,
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(textoLog),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _limpaTabela() async {
    final db = await DatabaseHelper().db;
    await db?.delete('Contato');
    idAutoIncrement = 1;
    setState(() {
      textoLog = 'A tabela foi limpa\n\n';
    });
  }

  void _insereNormal() async {
    // Inicia contagem de tempo
    final stopwatch = Stopwatch()..start();
    try {
      // Obtém conexão
      final db = await DatabaseHelper().db;
      // Inicia transaction
      await db?.transaction((txn) async {
        // Realiza diversas inserções
        for (var i = 1; i <= qtdTeste; i++) {
          await txn.insert('Contato', Contato(id: idAutoIncrement++, cpf: idAutoIncrement.toString(), nome: 'Teste $i', tipo: 'normal').toMap());
        }
      });
    } catch (e) {
      setState(() {
        textoLog += 'Ocorreu algum erro, verifique...\n\n';
        print(e.toString());
      });
    }
    // Exibe tempo da execução
    setState(() {
      textoLog += 'Executado normal em ${stopwatch.elapsed}..\n\n';
    });
    stopwatch.stop();
  }

  void _insereBatch() async {
    // Inicia contagem de tempo
    final stopwatch = Stopwatch()..start();
    try {
      // Obtém conexão
      final db = await DatabaseHelper().db;
      // Inicia transaction
      await db?.transaction((txn) async {
        // Inicia batch
        final batch = txn.batch();
        // Realiza diversas inserções
        for (var i = 1; i <= qtdTeste; i++) {
          batch.insert('Contato', Contato(id: idAutoIncrement++, cpf: i.toString(), nome: 'Teste $i', tipo: 'batch').toMap());
        }
        await batch.commit();
      });
    } catch (e) {
      setState(() {
        textoLog += 'Ocorreu algum erro, verifique...\n\n';
        print(e.toString());
      });
    }
    // Exibe tempo da execução
    setState(() {
      textoLog += 'Executado via batch em ${stopwatch.elapsed}..\n\n';
    });
    stopwatch.stop();
  }
}
