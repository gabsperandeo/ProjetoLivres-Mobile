import 'dart:convert';

import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:livres_entregas_mobile/utils/entregas_utils.dart';
import 'package:http/http.dart' as http;

class MinhasEntregasService {

  static const API = 'https://livres-entregas.herokuapp.com/api';
  final _erro = 'Algum erro ocorreu.';

  Future<APIResponse<List<Entrega>>> getMinhasEntregasList(String dt, String auth, String email) {
    var headers = {
      'Authorization':'Basic ' + auth,
      'Content-type':'application/json;charset=UTF-8'
    };

    var url = API + '/entregas/entregasResp?dataEntrega=' + dt + '&resp=' + email;

    return http.get(
      Uri.parse(url),
      headers: headers,
    ).then((data) {
      if(data.statusCode == 200) {
        final entregas = EntregasUtils().jsonToEntregasList(data.bodyBytes);

        return APIResponse<List<Entrega>>(
          data: entregas,
        );
      } else{
        return APIResponse<List<Entrega>>(
          error: true,
          errorMessage: utf8.decode(data.bodyBytes),
        );
      }
    })
        .catchError((_) => APIResponse<List<Entrega>>(error: true, errorMessage: _erro));
  }


  Future<APIResponse<String>> gerarRotas(String auth, List<Entrega> itens) {
    var headers = {
      'Authorization':'Basic ' + auth,
      'Content-type':'application/json;charset=UTF-8'
    };

    var url = API + '/entregas/roteirizar';

    return http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(itens),
    ).then((data) {
      if(data.statusCode == 200) {
        var result = utf8.decode(data.bodyBytes);
        return APIResponse<String>(
          data: result,
        );
      } else{
        return APIResponse<String>(
          error: true,
          errorMessage: utf8.decode(data.bodyBytes),
        );
      }
    })
        .catchError((_) => APIResponse<String>(error: true, errorMessage: _erro));
  }
}