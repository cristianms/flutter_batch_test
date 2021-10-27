import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textoLog = '';

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
                  child: Text('Insere 1000 normal'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: ElevatedButton(
                  onPressed: _insereBatch,
                  child: Text('Insere 1000 batch'),
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

  void _limpaTabela() {
    setState(() {
      textoLog = 'aaa';
    });
  }

  void _insereNormal() {
    setState(() {
      textoLog = 'bbb';
    });
  }

  void _insereBatch() {
    setState(() {
      textoLog = 'ccc';
    });
  }
}
