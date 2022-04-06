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
              
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255),
                  onSurface: Color.fromARGB(255, 130, 9, 151),
                  backgroundColor: Color.fromARGB(255, 130, 9, 151),
                ),
                child: Icon(Icons.camera_alt),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DocumentosPage(), fullscreenDialog: true)
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
