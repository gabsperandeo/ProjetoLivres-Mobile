import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen ({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titulo = 'Entrar';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        centerTitle: true,
        backgroundColor: Color(0xFFf26a4b),
      ),
      backgroundColor: Color(0xFFF0F0F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Utils().sizedBox(40),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}