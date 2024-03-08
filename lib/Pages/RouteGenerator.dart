// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/Pages/PaginaAllenamento.dart';
import 'package:progettomygimnuovo/services/AuthPage.dart';
import 'PaginaErrore.dart';
import 'PaginaMieiAllenamenti.dart';
import 'PaginaTimer.dart';
import 'PrimaPagina.dart';
import 'DataStorageDemo.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/orologio':
        return MaterialPageRoute(builder: (context) => PaginaTimer());

      case '/prima':
        return MaterialPageRoute(builder: (context) => PrimaPagina());

      case '/auth':
        return MaterialPageRoute(builder: (context) => AuthPage());

      case '/allenamento':
        return MaterialPageRoute(builder: (context) => PaginaAllenamento());
      
      case 'miei_allenamenti':
        return MaterialPageRoute(builder: (context) => PaginaMieiAllenamenti());
        // return MaterialPageRoute(builder: (context) => DataStorageDemo());

      default:
        return MaterialPageRoute(builder: (context) => PaginaErrore());
    }
  }
}
