import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/services/firebase_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_app/main.dart';
import 'package:tcc_app/cameraPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // final firestoreInstance = FirebaseFirestore.instance;
    // var firebaseUser = FirebaseAuth.instance.currentUser;
    // firestoreInstance.collection("usuarios").doc(firebaseUser.uid).set({
    // });
    super.initState();
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
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushReplacementNamed(
                    context, Constants.signInNavigate);
              },
            )
          ],
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.purple),
          title: Text("Home"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL),
                    radius: 20,
                  ),
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocumentosPage(),
                              fullscreenDialog: true));
                    },
                  ),
                ),
              ],
            )
          ],
        )));
  }
}
