import 'package:flutter/material.dart';
import 'package:tcc_app/cameraPage.dart';


class ScreenHome extends StatefulWidget {
  const ScreenHome({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 250,
              height: 250,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  shape: BoxShape.circle,
                ),
                height: 50,
                width: 50,
                child: TextButton(
                  child: Icon(Icons.camera_alt),
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DocumentosPage(), fullscreenDialog: true)
                    );
                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
