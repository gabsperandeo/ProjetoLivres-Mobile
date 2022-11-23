import 'dart:convert';

import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:http/http.dart' as http;

class AtualizarEntregasService {

  final _erro = 'Algum erro ocorreu.';
  static const API = 'https://livres-entregas.herokuapp.com/api';

  //método responsável por executar a chamada ao backend para atualizar as entregas
  Future<APIResponse<String>> atualizarEntregas(String dt, String auth, String email, List<Entrega> itens) {
    var headers = {
      'Authorization':'Basic ' + auth,
      'Content-type':'application/json;charset=UTF-8'
    };

    var url = API + '/entregas/atualizar/' + email;

    return http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(itens),
    ).then((data) {
      if(data.statusCode == 200) {  //se tiver sucesso
        return APIResponse<String>(data: utf8.decode(data.bodyBytes));
      } else{ //senão
        return APIResponse<String>(
          error: true,
          errorMessage: utf8.decode(data.bodyBytes),
        );
      }
    })
        .catchError((_) => APIResponse<List<Entrega>>(error: true, errorMessage: _erro));
  }

}