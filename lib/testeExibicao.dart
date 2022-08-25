import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/Atualizacao.dart';
import 'package:tcc_app/homePage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //SS: Fiz esta mudança no getList
  // Stream<QuerySnapshot> _getList() {
  Future<QuerySnapshot<Map<String, dynamic>>> _getList() {
    var dados = firestoreInstance
        .collection(firebaseUser!.uid)
        //SS: Exclui o where e tratar todos os dados
        // .where()
        // .where(_where)
        // .limit(99)
        .get()
        .then((value) {
      print(value.docs.asMap());
      // dados  = value;
      return value;
    });
    // .snapshots();
    //Fim mudança no getList

    return dados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        stream: _getList()
            .asStream(), //SS: Acho que inclui este asStream pois o builder espera um Stream
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //SS: Fiz as mudanças no ListView.builder
          return new ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                var myData = snapshot.data!.docs.elementAt(index); //.data();

                var isEnabled = true;
                if (myData['apagado'] == true) {
                  isEnabled = false;
                }

                return new Slidable(
                    child: ListTile(
                  title: Text(myData.get('texto')),
                  subtitle: Text(myData.get('tipo de lixo')),
                  enabled: isEnabled,
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
                ));

                // children: snapshot.data!.docs.map((document) {
                //   Timestamp t = document['data'];
                //   DateTime d = t.toDate();
                //   return Slidable(
                //       child: ListTile(
                //     title: Text("Tipo de Lixo: " + document['tipo de lixo']),
                //     subtitle: Text(d.toString()),
                //     trailing: Icon(
                //       Icons.arrow_forward_ios,
                //     ),
                //     onTap: () async {
                //       await Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Atualizacao(),
                //         ),
                //       );
                //     },
                //   ));
                // }).toList(),
              });
          // SS: Fim Mudanças no ListView
        },
      ),
    );
  }
}
