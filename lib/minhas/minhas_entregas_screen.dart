import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/models/api_response.dart';
import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/services/minhas_entregas_service.dart';
import 'package:livres_entregas_mobile/storage/user_secure_storage.dart';
import 'package:livres_entregas_mobile/storage/date_secure_storage.dart';
import 'package:livres_entregas_mobile/utils/entregas_utils.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/services/atualizar_entregas_service.dart';

class MinhasEntregasScreen extends StatefulWidget {

  MinhasEntregasScreen({Key? key}) : super(key: key);

  @override
  State<MinhasEntregasScreen> createState() => _MinhasEntregasScreenState();
}

class _MinhasEntregasScreenState extends State<MinhasEntregasScreen> {
  String _msg = 'Aguarde! Estamos buscando as suas entregas...';
  final _entregasResignadas = 'As entregas foram resignadas e estão na lista de entregas para serem selecionadas.';
  final _entregasEntregues = 'As entregas foram marcadas como entregue.';
  final _avisoSelecao = 'Marque as entregas que você deseja realizar uma ação.';
  final _erroSemData = 'Selecione uma data para listar as suas entregas.';
  final _semEntregas = 'Não há entregas selecionadas para esta data.';
  final List<Entrega> itens = [];

  String dt = '';
  String auth = '';
  String email = '';
  int? _count;

  @override
  initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 3.0),
                child: _resignar(),
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 3.0),
                child: _entregue(),
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(3.0, 10.0, 3.0, 3.0),
                child: _gerarRotas(),
              ),
            ),
          ],
        ),
        Utils().infoText(_msg, 0xFF086790, false),
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: EntregasUtils().listEntregas('', itens, _count),
          ),
        ),
      ],
    );
  }

  //método que devolve o widget do botão de RESIGNAR as entregas marcadas
  Widget _resignar() {
    return ElevatedButton(
      onPressed: dt.isNotEmpty ? () async {
        _atualizar(_entregasResignadas, false, false);
      } : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 16.0)),
      child: const Text('RESIGNAR'),
    );
  }

  //método que devolve o widget do botão para marcar a entrega como ENTREGUE
  Widget _entregue() {
    return ElevatedButton(
      onPressed: dt.isNotEmpty ? () async {
        _atualizar(_entregasEntregues, true, true);
      } : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 16.0)),
      child: const Text('ENTREGUE'),
    );
  }

  //método responsável por realizar a chamada ao backend da atualização das entregas marcadas
  _atualizar(String msgSucesso, bool selecionado, bool entregue) async {
    List<Entrega> entregas = EntregasUtils().listaItensAtualizar(itens, selecionado, entregue);

    if(entregas.isNotEmpty && entregas != null) {
      final result = await AtualizarEntregasService().atualizarEntregas(dt, auth, email, entregas);
      if(result.error) {
        _msg = result.errorMessage!;
      } else if(result.data != null && !result.error) {
        setState(() {
          _msg = msgSucesso;
          _callEntregas();
        });
      }
    } else {
      setState(() {
        _msg = _avisoSelecao;
      });
    }
  }

  //método que devolve o widget do botão de gerar rotas
  Widget _gerarRotas() {
    return ElevatedButton(
      onPressed: dt.isNotEmpty ? () async {
        _rotas();
      } : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 16.0)),
      child: const Text('ROTAS'),
    );
  }

  //método responsável por fazer a chamada ao backend para gerar as rotas das entregas marcadas
  _rotas() async {
    List<Entrega> entregas = EntregasUtils().listaItensAtualizar(itens, true, false);

    if(entregas.isNotEmpty && entregas != null) {
      APIResponse<String> resultadoMaps = await MinhasEntregasService().gerarRotas(auth, entregas);

      if(resultadoMaps.error) {
        _msg = resultadoMaps.errorMessage!;
      } else if(resultadoMaps.data != null && !resultadoMaps.error) {
        Navigator.pushNamed(
          context,
          '/maps',
          arguments: resultadoMaps.data.toString(),
        );
      }
    } else {
      setState(() {
        _msg = _avisoSelecao;
      });
    }
  }

  //método responsável por fazer o carregamento das "minhas entregas"
  Future _callEntregas() async {
    if(dt.isEmpty) {
      setState(() {
        _msg = _erroSemData;
      });
    } else {
      final result = await MinhasEntregasService().getMinhasEntregasList(dt, auth, email);
      itens.clear();

      if(result.error) {
        _msg = result.errorMessage!;
      } else if(result.data != null && !result.error) {
        for(var element in result.data!) {
          itens.add(element);
        }

        setState(() {
          _count = result.data!.length;
          _msg = (_count == 0) ? _semEntregas : '';
        });
      }
    }
  }

  //método responsável por carregar as informações de data, auth e e-mail que estão armazenadas
  Future init() async {
    dt = await DateSecureStorage.getDate() ?? '';
    auth = await UserSecureStorage.getAuth() ?? '';
    email = await UserSecureStorage.getEmail() ?? '';

    _callEntregas();  //realiza a chamada da listagem automática das entregas
  }
}