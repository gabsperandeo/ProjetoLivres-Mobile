import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/models/usuario.dart';
import 'package:livres_entregas_mobile/services/cadastro_service.dart';
import 'package:livres_entregas_mobile/cadastro/cadastro_redirect_screen.dart';

class CadastroForm extends StatefulWidget {
  CadastroForm({ Key? key }) : super(key: key);

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  String _msg = '';
  final _erroSenha = 'As senhas não estão iguais!';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Icon(
              Icons.directions_bike,
              size: 120.0,
              color: Color(0xFFec431d),
          ),
          Utils().sizedBox(20),
          Utils().campoFormulario(inputType : TextInputType.text, labelName : "Nome", ctlName : nomeController),
          Utils().campoFormulario(inputType : TextInputType.text, labelName : "Sobrenome", ctlName : sobrenomeController),
          Utils().campoFormulario(inputType : TextInputType.emailAddress, labelName : "E-mail", ctlName : emailController),
          _campoSenha(inputType : TextInputType.text, labelName : "Senha", ctlName : senhaController),
          _campoSenha(inputType : TextInputType.text, labelName : "Confirmar Senha", ctlName : confirmSenhaController),
          Utils().sizedBox(40),
          _cadastrarButton(),
          Utils().sizedBox(10),
        ],
      ),
    );
  }

  //método responsável por devolver o widget do campo de senha
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
          return "Preencha $labelName";
        } else if(ctlName == confirmSenhaController && value != senhaController.text) {
            return _erroSenha;
        }
        return null;
      },
    );
  }

  //método responsável por devolver o widget do botão de cadastro
  ElevatedButton _cadastrarButton() {
    return  ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _enviarCadastro();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFf26a4b),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 25.0
        ),
      ),
      child: const Text("Cadastrar"),
      );
  }

  //método responsável por realizar o envio do cadastro ao backend
  _enviarCadastro() async {
    var usuario = Usuario(
      nome : nomeController.text,
      sobrenome : sobrenomeController.text,
      email: emailController.text,
      senha: senhaController.text,
    );

    final result = await CadastroService().realizarCadastro(usuario);
    if(result.error) {
      _msg = result.errorMessage ?? 'Ocorreu algum erro.';
    } else if(result.data != null && !result.error) {
      _msg = result.data!;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroRedirectScreen(
          mensagem: _msg,
          erro: result.error)
      ),
    );
  }
}