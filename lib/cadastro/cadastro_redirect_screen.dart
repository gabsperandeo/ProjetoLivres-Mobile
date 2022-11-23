import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';

class CadastroRedirectScreen extends StatefulWidget {
  final String mensagem;
  final bool erro;

  const CadastroRedirectScreen ({Key? key, required this.mensagem,
    required this.erro})
      : super(key: key);

  @override
  State<CadastroRedirectScreen> createState() => _CadastroRedirectScreenState();
}

class _CadastroRedirectScreenState extends State<CadastroRedirectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _titulo = 'Cadastro';

  @override
  Widget build(BuildContext context){
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: _constructAppBar(widget.erro),
        backgroundColor: Color(0xFFF0F0F7),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Utils().infoText(widget.mensagem, 0xFF128EC3, true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //método responsável por devolver o widget da barra do aplicativo
  AppBar _constructAppBar(bool error) {
    return AppBar(
      title: Text(_titulo),
      centerTitle: true,
      backgroundColor: Color(0xFF80d9ff),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(onPressed: () {
          if(error) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamed(context, '/');
          }
        }, icon: const Icon(Icons.arrow_back))
      ],
    );
  }
}