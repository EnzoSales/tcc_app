import 'package:flutter/material.dart';
import 'package:tcc_app/Home.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({ Key key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children:<Widget> [
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Usuario"
                ),
              ),
            ),
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: "password"
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  onSurface: Colors.blue,
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreenHome()),
                  );
                },
                child: Text("Logar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}