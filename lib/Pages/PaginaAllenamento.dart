// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, unused_element

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovoAllenamento_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaAllenamento extends StatefulWidget {
  const PaginaAllenamento({super.key});

  @override
  State<PaginaAllenamento> createState() => _PaginaAllenamentoState();
}

class _PaginaAllenamentoState extends State<PaginaAllenamento> {
  List<String> rowsData = [];
  int numeroCard = 0;
  String nomeEsercizio = '';
  late DateTime sessionStartTime;
  int toccato = 0;

  @override
  void initState() {
    super.initState();
    sessionStartTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    void showFormDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return context.watch<nuovoAllenamento_provider>().generaForm();
          });
    }

    void dispose() {
      print("$sessionStartTime TEMPO ");
      final DateTime sessionEndTime = DateTime.now();
      final Duration sessionDuration =
          sessionEndTime.difference(sessionStartTime);
      super.dispose();
    }

    Widget? builder() {
      if (context.read<nuovoAllenamento_provider>().isSessionActive) {
        return context.watch<nuovoAllenamento_provider>().list_v;
      }
      return Center(
        child: Text(
          'AVVIA LA SESSIONE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          // forceMaterialTransparency: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prima');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.red,
              )),
          actions: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                if (toccato == 0) {
                  toccato++;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Vuoi iniziare una nuova sessione?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                toccato = 0;
                                Navigator.of(context).pop();
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<nuovoAllenamento_provider>()
                                    .startSession();
                                Navigator.of(context).pop();
                              },
                              child: Text('Si')),
                        ],
                      );
                    },
                  );
                }
                // context.read<nuovoAllenamento_provider>().startSession();
              },
            ),
            SizedBox(height: 20),
            context.watch<nuovoAllenamento_provider>().isSessionActive
                ? TextButton(
                    onPressed: () {
                      toccato = 0;
                      context.read<nuovoAllenamento_provider>().endSession();
                      // context.read<nuovoAllenamento_provider>().rimuovi();
                    },
                    child: Text('END', style: TextStyle(color: Colors.white)),
                  )
                : Container(),
          ],
        ),
        body: builder(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // await saveData(sessionStartTime.toString());
            context.read<nuovoAllenamento_provider>().setContext(context);
            context.read<nuovoAllenamento_provider>().azzera();
            numeroCard++;
            context.read<nuovoAllenamento_provider>().setNEsercizi(numeroCard);
            showFormDialog();
          },
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}


// Future<void> saveData(String data) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('nomeEsercizio', data);
// }
