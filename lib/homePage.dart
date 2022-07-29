import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_app/services/firebase_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_app/main.dart';
import 'package:tcc_app/cameraPage.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
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
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children:[
                  Container(
                    child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!),
                    radius: 20,
                  )),
                  Container(
                    child: Text("Denuncias enviadas:"),
                  ),
                  Container(
                    child:CheckboxListTile(
                      title: const Text('Animate Slowly'),
                      value: timeDilation != 1.0,
                      onChanged: (bool? value) {
                        setState(() {
                          timeDilation = value! ? 10.0 : 1.0;
                        });
                      },
                      secondary: const Icon(Icons.hourglass_empty),
                    )
                  )
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children:[
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
