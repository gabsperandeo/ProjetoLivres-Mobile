import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/utils/checkbox_widget.dart';

//classe responsável por ter métodos utilizáveis a respeito das entregas em outras classes
class EntregasUtils {
  //método responsável por devolver uma lista do objeto Entrega a partir do json recebido
  List<Entrega> jsonToEntregasList(Uint8List responseBody) {
    final jsonData = json.decode(utf8.decode(responseBody));
    final entregas = <Entrega>[];
    for(var item in jsonData) {
      final entrega = Entrega(
        id: item['id'],
        id_consumidor: item['id_consumidor'],
        nome_consumidor: item['nome_consumidor'],
        comunidade_consumidor: item['comunidade_consumidor'],
        telefone_consumidor: item['telefone_consumidor'],
        endereco_entrega: item['endereco_entrega'],
        opcao_entrega: item['opcao_entrega'],
        valor_entrega: item['valor_entrega'],
        selecionado: item['selecionado'],
        entregue: item['entregue'],
        data_entrega: item['data_entrega'],
      );

      entregas.add(entrega);
    }

    return entregas;
  }

  /*método responsável por devolver uma lista do objeto Entrega, dos itens que estiverem marcados
    além de marcá-los de acordo com os parâmetros de "selecionado" e "entregue" passados
   */
  List<Entrega> listaItensAtualizar(List<Entrega> itens, bool selecionado, bool entregue){
    List<Entrega> itensMarcados = List.from(itens.where((item) => item.checked));

    itensMarcados.forEach((item){
      item.selecionado = selecionado;
      item.entregue = entregue;
    });

    return itensMarcados;
  }

  //método responsável por devolver o widget de checkbox de acordo com a Lista passada
  Widget listEntregas(String msg, List<Entrega> itens, int? count) {
    if(count == null) {
      return Text('');
    } else if(count == 0) {
      return Text(msg);
    } else {
      return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: count!,
          separatorBuilder: (_, __) => const Divider(
            color: Color(0xFFf26a4b),
          ),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxWidget(item: itens[index]);
          }
      );
    }
  }
}