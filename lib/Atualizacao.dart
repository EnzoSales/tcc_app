import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Atualizacao extends StatefulWidget {
  final String myData;
  const Atualizacao({Key? key, required this.myData }) : super(key: key);

  @override
  State<Atualizacao> createState() => _AtualizacaoState();

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _AtualizacaoState extends State<Atualizacao> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
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

    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Atualização"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          firestoreInstance.collection(firebaseUser!.uid).doc(widget.myData).update({
                            "tipo de lixo": selectedValue,
                            "dataAtualização": DateTime.now(),
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Enviar"))
                  ])
            ],
          )),
    );
  }
}