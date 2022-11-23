import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/cadastro/cadastro_form.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen ({ Key? key }) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titulo = "Cadastro de Entregador";
  final _subtitulo = "Preencha o formulário completo.";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        centerTitle: true,
        backgroundColor: Color(0xFF80d9ff),
      ),
      backgroundColor: Color(0xFFF0F0F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Utils().infoText(_subtitulo, 0xFF128EC3, true),
              Utils().sizedBox(40),
              CadastroForm(),
            ],
          ),
        ),
      ),
    );
  }
}