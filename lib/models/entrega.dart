class Entrega {
  String id;
  int id_consumidor;
  String nome_consumidor;
  int comunidade_consumidor;
  String telefone_consumidor;
  String endereco_entrega;
  String opcao_entrega;
  double valor_entrega;
  bool selecionado;
  bool entregue;
  String data_entrega;
  bool checked;

  Entrega({
    required this.id,
    required this.id_consumidor,
    required this.nome_consumidor,
    required this.comunidade_consumidor,
    required this.telefone_consumidor,
    required this.endereco_entrega,
    required this.opcao_entrega,
    required this.valor_entrega,
    required this.selecionado,
    required this.entregue,
    required this.data_entrega,
    this.checked = false,
  });

  Map toJson() => {
    'id': id,
    'id_consumidor': id_consumidor,
    'nome_consumidor': nome_consumidor,
    'comunidade_consumidor': comunidade_consumidor,
    'telefone_consumidor': telefone_consumidor,
    'endereco_entrega': endereco_entrega,
    'opcao_entrega': opcao_entrega,
    'valor_entrega': valor_entrega,
    'selecionado': selecionado,
    'entregue': entregue,
    'data_entrega': data_entrega,
  };
}