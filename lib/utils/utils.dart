import 'package:flutter/material.dart';

//classe responsável por ter métodos utilizáveis em várias outras classes
class Utils {
  //método responsável por devolver um widget de SizedBox de tamanho parametrizável
  SizedBox sizedBox(double altura) {
    return SizedBox(
      height: altura,
    );
  }

  //método responsável por fechar uma navegação
  returnPage(BuildContext context) {
    Navigator.pop(context);
  }

  //método responsável por devolver um widget do tipo campo texto para utilizar nos formulários
  TextFormField campoFormulario({TextInputType ?inputType, String ?labelName, var ctlName}) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: TextStyle(color: Color(0xFF29abe2)),
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color(0xFFf26a4b), fontSize: 20.0),
      controller: ctlName,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Preencha $labelName';
        }
        return null;
      },
    );
  }

  //método responsável por devolver um widget de texto que não pode ser selecionado
  SelectionContainer infoText(String texto, int cor, bool bold) {
    return SelectionContainer.disabled(
      child:Text(texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(cor),
          fontSize: 18,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  //método responsável por devolver um widget de texto formatado para as listas de entregas
  RichText textoListas(int comunidade, String nome, String telefone, String end, double valor) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13.0,
          color: Color(0xFF086790),
        ),
        children: <TextSpan>[
          TextSpan(text: 'Comunidade do Consumidor: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '$comunidade\n'),
          TextSpan(text: 'Nome do Consumidor: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '$nome\n'),
          TextSpan(text: 'Telefone: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '$telefone\n'),
          TextSpan(text: 'Endereço: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '$end\n'),
          TextSpan(text: 'Valor: R\$', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '$valor\n'),
        ],
      ),
    );
  }
}
