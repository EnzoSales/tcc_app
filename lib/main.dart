import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // throw UnimplementedError();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment(0,0) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Text("Pagina de Login"),
              ],
            ),
          )
        ),
      ),
    );
  }

} 