import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovaSessione_provider.dart';
import 'package:progettomygimnuovo/providers/nuovoAllenamento_provider.dart';
import 'package:progettomygimnuovo/providers/timer_provider.dart';
import 'package:provider/provider.dart';


import 'firebase_options.dart';
import 'pages/PrimaPagina.dart';
import 'pages/RouteGenerator.dart';
import 'services/Auth.dart';
import 'services/AuthPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => timer_provider()),
      ChangeNotifierProvider(create: (_) => nuovoAllenamento_provider()),
      ChangeNotifierProvider(create: (_) => nuovaSessione_provider()),
    ],
    child: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
            backgroundColor: Colors.white,
            errorColor: Colors.red,
          ),
        ),
        home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PrimaPagina();
            } else {
              return const AuthPage();
            }
          },
        ),
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
