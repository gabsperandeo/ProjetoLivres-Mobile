import 'package:livres_entregas_mobile/models/usuario.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroService {

  final _erro = 'Algum erro ocorreu.';
  static const API = 'https://livres-entregas.herokuapp.com/api';
  static const headers = {
    'Content-type':'application/json;charset=UTF-8'
  };

  Future<APIResponse<String>> realizarCadastro(Usuario usuario) {
    return http.post(
      Uri.parse(API + '/cadastroUsuario'),
      headers: headers,
      body: json.encode(usuario.toJson())
    ).then((data) {
      if(data.statusCode == 200 || data.statusCode == 201) {
        return APIResponse<String>(data: utf8.decode(data.bodyBytes));
      } else{
        return APIResponse<String>(
          error: true,
          errorMessage: utf8.decode(data.bodyBytes),
        );
      }
    }).catchError((_) => APIResponse<String>(error: true, errorMessage: _erro));
  }

}