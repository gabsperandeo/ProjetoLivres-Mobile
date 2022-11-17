import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:livres_entregas_mobile/utils/utils.dart';
import 'package:livres_entregas_mobile/storage/date_secure_storage.dart';

class SelectDateScreen extends StatefulWidget {

  SelectDateScreen({Key? key}) : super(key: key);

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateRangePickerController _dateController = DateRangePickerController();
  final msg = 'Ecobiker, por favor, selecione a data que serão feitas as entregas.';

  @override
  initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 20.0, 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Utils().infoText(msg, 0xFF086790, false),
            Utils().sizedBox(80),
            _datePicker(),
            _selecionarButton(),
          ],
        ),
      ),
    );
  }

  //método responsável por armazenar a data selecionada no calendário
  Future _storageDateInfo() async {
    final DateTime? dataSelecionada = _dateController.selectedDate;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if(_dateController.selectedDate != null) {
      await DateSecureStorage.setDate(formatter.format(dataSelecionada!));
    }
  }

  //método responsável por trazer a data armazenada no carregamento da tela
  Future init() async {
    String dt = await DateSecureStorage.getDate() ?? '';
    _dateController.selectedDate = new DateFormat('yyyy-MM-dd').parse(dt);

    if(DateTime.now().compareTo(DateTime.parse(dt)) > 0) {
      await DateSecureStorage.setDate(null);
    }
  }

  //método responsável por devolver o widget do botão de selecionar a data
  ElevatedButton _selecionarButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _storageDateInfo();
      },
      icon: Icon(
        Icons.calendar_month,
        size: 26.0,
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfda591),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 18.0)),
      label: Text('SELECIONAR DATA'),
    );
  }

  //método responsável por devolver o widget de calendário da seleção de datas
  SfDateRangePicker _datePicker() {
    return SfDateRangePicker(
      selectionMode: DateRangePickerSelectionMode.single,
      enablePastDates : false,  //desabilitar datas passadas
      view: DateRangePickerView.month,
      controller: _dateController,
      monthCellStyle: DateRangePickerMonthCellStyle(
        disabledDatesTextStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Color(0xFFec431d),
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 11,
        ),
      ),
      selectableDayPredicate: (DateTime date) { //restringir as seleções apenas às terças e sábados
        if (date.weekday != DateTime.saturday && date.weekday != DateTime.tuesday) {
          return false;
        }
        return true;
      },
      headerStyle: DateRangePickerHeaderStyle(  //estilo do cabeçalho do calendário
          backgroundColor: Color(0xFFfda591),
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 24,
            letterSpacing: 5,
            color: Color(0xFFff5eaea),
          )
      ),
      monthViewSettings: DateRangePickerMonthViewSettings(
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: TextStyle(color: Color(0xFF128EC3),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      selectionColor: Color(0xFF80d9ff),
      todayHighlightColor: Color(0xFF80d9ff),
    );
  }
}