import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/testeExibição.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Lancamento extends StatefulWidget {
  final XFile picture;
  const Lancamento({Key? key, required this.picture}) : super(key: key);

  @override
  State<Lancamento> createState() => _LancamentoState();

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _LancamentoState extends State<Lancamento> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
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

    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;

    File? _photo;
    _photo = File(widget.picture.path);
    Future uploadFile() async {
      if (_photo == null) return;
      final fileName = basename(widget.picture.path);
      final URL = firebaseUser!.uid;
      final destination = 'files/$URL/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');
        await ref.putFile(_photo);
      } catch (e) {
        print('error occured');
      }
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Lançamento"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.file(File(widget.picture.path),
                          fit: BoxFit.cover, width: 200),
                      const SizedBox(height: 20),
                      // Text(widget.picture.name)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          firestoreInstance.collection(firebaseUser!.uid).add({
                            "tipo de lixo": selectedValue,
                            "data": DateTime.now(),
                            "Local": GeoPoint(lat, long),
                            "concluido": false,
                            "apagado": false
                          });
                          uploadFile();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyApp(),
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
