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

  Future<QuerySnapshot<Map<String, dynamic>>> _getList() {
    var dados = firestoreInstance
        .collection(firebaseUser!.uid)
        .get()
        .then((value) {
      print(value.docs.asMap());
      return value;
    });

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
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return new ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                var myData = snapshot.data!.docs.elementAt(index);

                SlidableAction _act_delete = new SlidableAction(
                          flex: 2,
                          onPressed: (context) => 
                            FirebaseFirestore.instance.collection(firebaseUser!.uid).doc(myData.id).update({
                              "apagado": true
                            }),
                          backgroundColor: Color.fromARGB(255, 212, 28, 28),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        );
                SlidableAction _act_concluir = new SlidableAction(
                          onPressed: (context) => 
                            FirebaseFirestore.instance.collection(firebaseUser!.uid).doc(myData.id).update({
                              "concluido": true
                            }),
                          backgroundColor: Color.fromARGB(255, 3, 207, 13),
                          foregroundColor: Colors.white,
                          icon: Icons.check,
                          label: 'Concluido',
                        );
                SlidableAction _act_editar = new SlidableAction(
                          onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Atualizacao(myData:myData.id),
                            ),
                          ),
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.edit_note,
                          label: 'Editar',
                        );
                

                var isEnabled = true;
                if (myData['apagado'] == true) {
                  isEnabled = false;
                }
                else if(myData['concluido'] == true){
                  isEnabled = false;
                }

                List<SlidableAction> myAct = [];
                if (isEnabled == true) {
                  myAct = [_act_delete, _act_concluir, _act_editar];
                }
                String id = myData.id;

                  return new Slidable(
                  key: ValueKey(0),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: myAct,
                    ),
                    child: ListTile(
                  title: Text(myData.id),
                  subtitle: Text(myData.get('tipo de lixo')),
                  enabled: isEnabled,
                ));
              });
        },
      ),
    );
  }
}
