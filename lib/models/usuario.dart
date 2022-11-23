class Usuario {
  String nome;
  String sobrenome;
  String email;
  String senha;

  Usuario({
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha
  });

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "sobrenome": sobrenome,
      "email": email,
      "senha": senha,
    };
  }
}