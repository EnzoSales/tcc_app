import 'package:easy_debounce/easy_debounce.dart';
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
                Padding(
                 padding: EdgeInsetsDirectional.all(25),
                  child: TextFormField(
                    // onChanged: ,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Email',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(25),
                  child:TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Senha',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                    },
                  )
                ),
                Padding(
                  padding: EdgeInsetsDirectional.zero,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Color.fromARGB(255, 25, 8, 175),
                      backgroundColor: Color.fromARGB(255, 25, 8, 175)
                    ),
                    child: Text("Logar"),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

} 