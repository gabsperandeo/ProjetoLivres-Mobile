class UsuarioLogin {
  String username;
  String password;

  UsuarioLogin({
    required this.username,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}