import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/homePage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:tcc_app/cameraPage.dart';

class Lancamento extends StatefulWidget {
  const Lancamento({Key? key}) : super(key: key);

  @override
  State<Lancamento> createState() => _LancamentoState();

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _LancamentoState extends State<Lancamento> {
  double lat = 0.0;
  double long = 0.0;
  String erro = "";
  final List<String> items = [
    'Lixo Comum',
    'Reciclavel',
    'Caçamba',
    'Entulho',
    'Moveis/Eletronicos',
    'Lixo Toxico'
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    getPosicao();
    // DateTime data = DateTime.now();

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
                    )),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                        onPressed: () {
                          final firestoreInstance = FirebaseFirestore.instance;
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          firestoreInstance.collection(firebaseUser!.uid).add({
                            "tipo de lixo": selectedValue,
                            "data": DateTime.now(),
                            "Local": {
                              "latitude": lat,
                              "longitude": long,
                              "concluido": false,
                              "apagado": false
                            }
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                  fullscreenDialog: true));
                        },
                        child: Text("Enviar"))
                  ])
            ],
          )),
    );
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    } catch (e) {
      erro = e.toString();
    }
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error("Por favor habilite a nocalização no smartphone");
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error("Você precisa autorizar o acesso a localização");
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error("Você precisa autorizar o acesso a localização");
    }

    return await Geolocator.getCurrentPosition();
  }
}
