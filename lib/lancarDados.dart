import 'package:flutter/material.dart';

class Lancamento extends StatefulWidget {
  const Lancamento({ Key key }) : super(key: key);

  @override
  State<Lancamento> createState() => _LancamentoState();
}

class _LancamentoState extends State<Lancamento> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lançamento"),
          centerTitle: true,
        ),
      ),
      
    );
  }
}