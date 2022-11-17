import 'package:flutter/material.dart';
import 'package:livres_entregas_mobile/data/select_date_screen.dart';
import 'package:livres_entregas_mobile/entregas/entregas_screen.dart';
import 'package:livres_entregas_mobile/minhas/minhas_entregas_screen.dart';
import 'package:livres_entregas_mobile/invalidas/entregas_invalidas_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen ({ Key? key }) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<String> _screensTitle = [
    'Data',
    'Entregas',
    'Minhas Entregas',
    'Entregas Inválidas',
  ];

  @override
  Widget build(BuildContext context){
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_screensTitle[_selectedIndex],
              style: const TextStyle(
                color: Color(0xFF80d9ff),
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF086790),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: _buildNavBar(),
          backgroundColor: Color(0xFFF0F0F7),
          body: _showScreen(_screensTitle[_selectedIndex]),
        )
      );
  }

  //método responsável por devolver a barra de navegação inferior interna do app
  BottomNavigationBar _buildNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: Color(0xFF9AE1FF),
      unselectedItemColor: Color(0xFF086790),
      selectedItemColor: Color(0xFFF0F0F7),
      selectedFontSize: 14,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.date_range),
          label: 'Data',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Entregas',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Minhas',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.not_listed_location),
            label: 'Inválidas',
        ),
      ],
    );
  }

  //método responsável por selecionar o index ao clicar em um dos ícones do menu
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //método responsável por devolver o widget com as telas de acordo com o índice selecionado
  Widget _showScreen(String screenTitle) {
    if(screenTitle == 'Data') {
      return SelectDateScreen();
    } else if(screenTitle == 'Entregas') {
      return EntregasScreen();
    } else if(screenTitle == 'Minhas Entregas') {
      return MinhasEntregasScreen();
    } else if(screenTitle == 'Entregas Inválidas') {
      return EntregasInvalidasScreen();
    }

    return Column();
  }
}