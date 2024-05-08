import 'package:basededatos/firebase_options.dart';
import 'package:basededatos/pages/catalogo.dart';
import 'package:basededatos/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:basededatos/preferences/preference_user.dart';
import 'package:basededatos/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciasUsuario.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.ultimaPagina,
      routes: {
        LoginPage.routename  :(context) =>  LoginPage(),
        DashboardPage.routename  :(context) =>  const DashboardPage(),
        Catalogo.routename  :(context) =>  const Catalogo(),

      },
    );
  }
}

