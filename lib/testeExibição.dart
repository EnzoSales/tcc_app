import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/Atualizacao.dart';
import 'package:tcc_app/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: AddData(),
    );
  }
}

class AddData extends StatelessWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> _getList() {
    var dados = firestoreInstance
        .collection(firebaseUser!.uid)
        .where("apagado", isEqualTo: false)
        .where("concluido", isEqualTo: false)
        .limit(99)
        .snapshots();
    return dados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(),
                      fullscreenDialog: true));
            },
          )
        ],
        backgroundColor: Colors.blue,
        title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: _getList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              Timestamp t = document['data'];
              DateTime d = t.toDate();
              return ListTile(
                title: Text("Tipo de Lixo: " + document['tipo de lixo']),
                subtitle: Text(d.toString()),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Atualizacao(),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
