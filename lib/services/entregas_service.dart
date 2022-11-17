import 'dart:convert';

import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:livres_entregas_mobile/utils/entregas_utils.dart';
import 'package:http/http.dart' as http;

class EntregasService {

  final _erro = 'Algum erro ocorreu.';
  static const API = 'https://livres-entregas.herokuapp.com/api';

  Future<APIResponse<List<Entrega>>> getEntregasList(String dt, String auth) {
    var headers = {
      'Authorization':'Basic ' + auth,
      'Content-type':'application/json;charset=UTF-8'
    };

    var postData = {
      'dataEntrega':dt
    };

    return http.post(
        Uri.parse(API + '/entregas'),
        headers: headers,
        body: json.encode(postData),
      ).then((data) {
      if(data.statusCode == 200) {
        final entregas = EntregasUtils().jsonToEntregasList(data.bodyBytes);

        return APIResponse<List<Entrega>>(
          data: entregas,
        );
      } else{
        return APIResponse<List<Entrega>>(
          error: true,
          errorMessage: _erro,
        );
      }
    })
        .catchError((_) => APIResponse<List<Entrega>>(error: true, errorMessage: _erro));
  }

}