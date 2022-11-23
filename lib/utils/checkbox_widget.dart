import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({ Key? key, required this.item }) : super(key: key);

  final Entrega item;

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Utils().textoListas(widget.item.comunidade_consumidor, widget.item.nome_consumidor,
        widget.item.telefone_consumidor, widget.item.endereco_entrega, widget.item.valor_entrega,),
      value: widget.item.checked,
      onChanged: (bool? value){
        setState((){
          widget.item.checked = value!;
        });
      },
      activeColor: Color(0xFFec431d),
    );
  }
}