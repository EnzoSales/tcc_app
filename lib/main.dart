import 'dart:js';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:tcc_app/Home.dart';

void main() {
  runApp(Login());
}

//flutter stateless widget
 class Login extends StatefulWidget {
  const Login({ Key key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void Conect() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SafeArea(
            child: Align(
          alignment: Alignment(0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Text("Pagina de Login"),
              Padding(
                padding: EdgeInsetsDirectional.all(25),
                child: TextFormField(
                  // onChanged: ,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Usuario',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.all(25),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Senha',
                    ),
                  )),
              Padding(
                padding: EdgeInsetsDirectional.zero,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Color.fromARGB(255, 6, 248, 19),
                      backgroundColor: Color.fromARGB(255, 6, 248, 19)),
                  onPressed: Conect,
                  child: Text("Logar"),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}