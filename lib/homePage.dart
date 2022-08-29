import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcc_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_app/main.dart';
import 'package:tcc_app/cameraPage.dart';
import 'package:tcc_app/Exibicao.dart';
import 'package:camera/camera.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
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
          leading: Container(
                      child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!),
                    radius: 20,
                  )),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                  child: Container(
                    color: Color.fromARGB(255, 2, 141, 255),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MyApp()));
                      },
                      child: Text(
                        "Denuncias",
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Color.fromARGB(255, 255, 255, 255),
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),                      
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await availableCameras().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CameraPage(cameras: value))));
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        )));
  }
}
/**/
