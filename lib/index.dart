import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen ({ Key? key }) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final _welcomeMessage = 'Bem-vindo, Ecobiker!\n Crie sua conta ou acesse-a.';

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F7),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 120.0, 10.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _imgLogo(),
                  Utils().sizedBox(80),
                  Utils().infoText(_welcomeMessage, 0xFF086790, false),
                  Utils().sizedBox(10),
                  _criarContaButton(),
                  _entrarButton(),
                ],
              ),
            ),
        ),
    );
  }

  //método responsável por devolver o widget do botão para criar conta
  ElevatedButton _criarContaButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/cadastro');
      },
      icon: Icon(
        Icons.app_registration,
        size: 26.0,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFf26a4b),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 18.0)),
      label: Text('CRIAR CONTA'),
    );
  }

  //método responsável por devolver o widget do botão para realizar o login
  OutlinedButton _entrarButton() {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 2.0, color: Color(0xFF29abe2)),
        textStyle: const TextStyle(
            fontSize: 18.0),
      ),
      icon: Icon(
        Icons.login,
        size: 26.0,
      ),
      label: Text('ENTRAR'),
    );
  }

  //método responsável por devolver o logo em um widget circular
  CircleAvatar _imgLogo() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/Logo-livres.png'),
      radius: 140,
    );
  }
}