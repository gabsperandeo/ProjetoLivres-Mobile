import 'package:livres_entregas_mobile/models/usuario_login.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:livres_entregas_mobile/storage/user_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {

  final _erro = 'Algum erro ocorreu.';
  static const API = 'https://livres-entregas.herokuapp.com';

  //método responsável por executar a chamada ao backend para efetuar o login
  Future<APIResponse<String>> realizarLogin(UsuarioLogin usuario) {

    return http.post(
        Uri.parse(API + '/login'),
        body: usuario.toJson()
    ).then((data) {
      if(data.statusCode == 200) {  //se tiver sucesso
        _storageUserInfo(usuario.username, usuario.password);
        return APIResponse<String>(data:  utf8.decode(data.bodyBytes));
      } else{ //senão
        return APIResponse<String>(
          error: true,
          errorMessage: utf8.decode(data.bodyBytes),
        );
      }
    }).catchError((_) => APIResponse<String>(error: true, errorMessage: _erro));
  }

  //método responsável por armazenar as informações do login realizado com sucesso
  Future _storageUserInfo(String email, String senha) async {
    String credentials = email + ':' + senha;
    await UserSecureStorage.setEmail(email);
    await UserSecureStorage.setAuth(base64.encode(utf8.encode(credentials)));
  }
}