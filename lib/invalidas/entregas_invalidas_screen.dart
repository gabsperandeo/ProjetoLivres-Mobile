import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/services/entregas_invalidas_service.dart';
import 'package:livres_entregas_mobile/storage/user_secure_storage.dart';
import 'package:livres_entregas_mobile/storage/date_secure_storage.dart';
import 'package:livres_entregas_mobile/models/entrega.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';

class EntregasInvalidasScreen extends StatefulWidget {

  EntregasInvalidasScreen({Key? key}) : super(key: key);

  @override
  State<EntregasInvalidasScreen> createState() => _EntregasInvalidasScreenState();
}

class _EntregasInvalidasScreenState extends State<EntregasInvalidasScreen> {
  final _erroSemData = 'Selecione uma data para listar as entregas inválidas.';
  final _semEntregasInvalidas = 'Não há entregas inválidas para esta data.';
  final List<Entrega> itens = [];

  String dt = '';
  String auth = '';
  int? _count;
  String _msg = 'As entregas inválidas são as que precisam ser realizadas, '
                'mas estão sem endereço. Portanto, é necessário ajustá-las.';

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
        Utils().sizedBox(20),
        Utils().infoText(_msg, 0xFF086790, false),
        _listarEntregasInvalidas(),
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: _listEntregas(),
          ),
        ),
      ],
    );
  }

  //método responsável por devolver o widget de botão de listar as entregas inválidas
  Widget _listarEntregasInvalidas() {
    return ElevatedButton.icon(
      onPressed: dt.isNotEmpty ? () async {
        final result = await EntregasInvalidasService().getEntregasInvalidasList(dt, auth);
        if(result.error) {
          _msg = result.errorMessage!;
        } else if(result.data != null && !result.error) {
          for(var element in result.data!) {
            itens.add(element);
          }

          setState(() {
            _count = result.data!.length;
          });
        }
      } : null,
      icon: Icon(
        Icons.not_listed_location,
        size: 26.0,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 18.0)),
      label: Text('LISTAR'),
    );
  }

  //método responsável por devolver o widget da lista das entregas inválidas (ou mensagem)
  Widget _listEntregas() {
    if(_count == null) {
      return Text('');
    } else if(_count == 0) {
      return Text(_semEntregasInvalidas);
    } else {
      return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: _count!,
          separatorBuilder: (_, __) => const Divider(
            color: Color(0xFFf26a4b),
          ),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Utils().textoListas(itens[index].comunidade_consumidor, itens[index].nome_consumidor,
                itens[index].telefone_consumidor, itens[index].endereco_entrega, itens[index].valor_entrega,)
            );
          }
      );
    }
  }

  //método responsável por carregar as informações de data e auth que estão armazenadas
  Future init() async {
    dt = await DateSecureStorage.getDate() ?? '';
    auth = await UserSecureStorage.getAuth() ?? '';

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