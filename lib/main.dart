import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:livres_entregas_mobile/index.dart';
import 'package:livres_entregas_mobile/login/login_screen.dart';
import 'package:livres_entregas_mobile/cadastro/cadastro_screen.dart';
import 'package:livres_entregas_mobile/nav_screen.dart';
import 'package:livres_entregas_mobile/minhas/maps.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Index(),
      '/cadastro': (context) => const CadastroScreen(),
      '/login': (context) => const LoginScreen(),
      '/nav': (context) => const NavScreen(),
      '/maps': (context) => Maps(),
    },
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('pt', 'BR'),
    ],
    locale: const Locale('pt', 'BR'),
  ));
}

class Index extends StatefulWidget {
  const Index ({ Key? key }) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return IndexScreen();
  }
}