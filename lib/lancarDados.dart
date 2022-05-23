import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Lancamento extends StatefulWidget {
  const Lancamento({ Key key }) : super(key: key);

  @override
  State<Lancamento> createState() => _LancamentoState();
}

class _LancamentoState extends State<Lancamento> {

  double lat = 0.0;
  double long = 0.0;
  String erro = "";


  @override
  Widget build(BuildContext context) {
    DateTime data = DateTime.now();
    // bool _value = false;
    int val = -1;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lançamento"),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container( 
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Local"
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    )
                  ),
                ),
                Text(
                  "Data/Horario"
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    )
                  ),
                  child: Text(DateFormat("'Data numérica:' dd/MM/yyyy").format(data)),
                ),
                Text(
                  "Tipo de Lixo:"
                ),
                ListTile(
                  title: Text("Lixo Comum"),
                  leading: Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),
                ListTile(
                  title: Text("Reciclavel"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),
                ListTile(
                  title: Text("Caçamba"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),ListTile(
                  title: Text("Entulho/Moveis"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),ListTile(
                  title: Text("Reciclavel"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),ListTile(
                  title: Text("Lixo Toxico"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    activeColor: Color.fromRGBO(156, 39, 176, 1),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
  getPosicao() async{
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    } catch (e){
      erro = e.toString();
    }  
  }

  Future<Position>_posicaoAtual() async{
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if(! ativado){
      return Future.error("Por favor habilite a nocalização no smartphone");
    }

    permissao = await Geolocator.checkPermission();
    if(permissao == LocationPermission.denied){

      permissao = await Geolocator.requestPermission();
      if(permissao == LocationPermission.denied){
        return Future.error("Você precisa autorizar o acesso a localização");
      }
    }

    if(permissao == LocationPermission.deniedForever){
      return Future.error("Você precisa autorizar o acesso a localização");
    }

    return await Geolocator.getCurrentPosition();
  }
}