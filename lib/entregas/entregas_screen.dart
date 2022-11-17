import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/storage/user_secure_storage.dart';
import 'package:livres_entregas_mobile/storage/date_secure_storage.dart';
import 'package:livres_entregas_mobile/utils/entregas_utils.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/services/entregas_service.dart';
import 'package:livres_entregas_mobile/services/atualizar_entregas_service.dart';

class EntregasScreen extends StatefulWidget {

  EntregasScreen({Key? key}) : super(key: key);

  @override
  State<EntregasScreen> createState() => _EntregasScreenState();
}

class _EntregasScreenState extends State<EntregasScreen> {
  final _entregasSelecionadas = 'Suas entregas foram selecionadas e encontram-se em "Minhas Entregas"';
  final _avisoSelecao = 'Marque as entregas que você deseja selecionar para si.';
  final _semEntregasValidas = 'Não há entregas para esta data.';
  final _erroSemData = 'Selecione uma data para listar as entregas.';
  final List<Entrega> itens = [];

  String dt = '';
  String auth = '';
  String email = '';
  int? _count;
  String _msg = '';

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
                padding: const EdgeInsets.all(10.0),
                child: _listarEntregas(),
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: _selecionarEntregas(),
              ),
            ),
          ],
        ),
        Utils().infoText(_msg, 0xFF086790, false),
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: EntregasUtils().listEntregas(_semEntregasValidas, itens, _count),
          ),
        ),
      ],
    );
  }

  //método responsável por devolver o widget que listará as entregas (somente se houver data selecionada)
  Widget _listarEntregas() {
    return ElevatedButton.icon(
      onPressed: dt.isNotEmpty ? () async {
        final result = await EntregasService().getEntregasList(dt, auth);
        if(result.error) {
          _msg = result.errorMessage!;
        } else if(result.data != null && !result.error) {
          for(var element in result.data!) {
            itens.add(element);
          }

          setState(() {
            _msg = '';
            _count = result.data!.length;
          });
        }
      } : null,
      icon: Icon(
        Icons.format_list_bulleted,
        size: 26.0,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 18.0)),
      label: Text("LISTAR"),
    );
  }

  //método responsável por devolver o widget de botão de seleção de entregas
  Widget _selecionarEntregas() {
    return ElevatedButton.icon(
      onPressed: dt.isNotEmpty ? () async {
        List<Entrega> entregas = EntregasUtils().listaItensAtualizar(itens, true, false);

        if(entregas.isNotEmpty && entregas != null) {
          final result = await AtualizarEntregasService().atualizarEntregas(dt, auth, email, entregas);
          if(result.error) {
            _msg = result.errorMessage!;
          } else if(result.data != null && !result.error) {
            setState(() {
              _msg = _entregasSelecionadas;
              _count = null;
              itens.clear();
            });
          }
        } else {
          setState(() {
            _msg = _avisoSelecao;
          });
        }
      } : null,
      icon: Icon(
        Icons.bookmark_added_outlined,
        size: 26.0,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 16.0)),
      label: Text('SELECIONAR'),
    );
  }

  //método responsável por carregar as informações de data, auth e e-mail que estão armazenadas
  Future init() async {
    dt = await DateSecureStorage.getDate() ?? '';
    auth = await UserSecureStorage.getAuth() ?? '';
    email = await UserSecureStorage.getEmail() ?? '';

    _validateDate();
  }

  /*método responsável por validar a existência de uma data selecionada ou não
    a fim de controlar se os botões estarão habilitados ou não*/
  Future _validateDate() async {
    if(dt.isEmpty) {
      setState(() {
        _msg = _erroSemData;
      });
    } else {
      setState(() {
        _msg += '';
      });
    }
  }
}