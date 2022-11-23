import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/services/login_service.dart';
import 'package:livres_entregas_mobile/models/usuario_login.dart';

class LoginForm extends StatefulWidget {
  LoginForm({ Key? key }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _erroLogin = 'Algo deu errado no seu login. Informe seus dados.';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  String _msg = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Icon(
            Icons.account_circle,
            size: 120.0,
            color: Color(0xFF80d9ff),
          ),
          Utils().sizedBox(20),
          Utils().campoFormulario(inputType : TextInputType.emailAddress, labelName : 'E-mail', ctlName : emailController),
          _campoSenha(inputType : TextInputType.text, labelName : 'Senha', ctlName : senhaController),
          Utils().sizedBox(40),
          Utils().infoText(_msg, 0xFF086790, false),
          _entrarButton(),
        ],
      ),
    );
  }

  //método que devolve o widget de campo texto responsável pela senha
  TextFormField _campoSenha({TextInputType ?inputType, String ?labelName, var ctlName}) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: TextStyle(color: Color(0xFF29abe2)),
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color(0xFFf26a4b), fontSize: 20.0),
      controller: ctlName,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value){
        if(value == null || value.isEmpty) {
          return 'Preencha $labelName';
        }
        return null;
      },
    );
  }

  //método que devolve o widget de botão para realizar o login
  ElevatedButton _entrarButton() {
    return  ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {

          var usuario = UsuarioLogin(
            username : emailController.text,
            password : senhaController.text,
          );

          final result = await LoginService().realizarLogin(usuario);
          if(result.error) {
            _resetFields();
          } else if(result.data != null && !result.error) {
            Navigator.pushNamed(context, '/nav');
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF29abe2),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 25.0
        ),
      ),
      child: const Text('Entrar'),
    );
  }

  //método responsável por limpar os campos de e-mail e senha
  void _resetFields() {
    emailController.clear();
    senhaController.clear();
    setState(() {
      _msg = _erroLogin;
    });
  }
}