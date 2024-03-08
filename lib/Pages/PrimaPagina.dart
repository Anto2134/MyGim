// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/services/Auth.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';
import '../widgets/card_allenamento.dart';
import '../widgets/card_miei_allenamenti.dart';
import '../widgets/card_schede.dart';

class PrimaPagina extends StatefulWidget {
  const PrimaPagina({super.key});

  @override
  State<PrimaPagina> createState() => _PrimaPaginaState();
}

class _PrimaPaginaState extends State<PrimaPagina> {
  Widget verifica_tempo() {
    if (context.watch<timer_provider>().tempo_secondi == 0)
      return Container(
        height: 2,
        color: Colors.black,
      );
    return Text(
      '${context.watch<timer_provider>().tempo_secondi}',
      style: TextStyle(
        color: coloreNumero(),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Future<void> signOut() async {
    Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: verifica_tempo(),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'MYHOMEGYM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 5,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  card_allenamento(),
                  card_miei_allenamenti(),
                  card_schede(),
                ],
              ),
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt, color: Colors.white),
            label: 'TRAINING',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_outlined),
            label: 'prima pagina',
          ),
        ],
        backgroundColor: Colors.black,
        selectedLabelStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/orologio');
        },
        child: Icon(Icons.timer_sharp),
      ),
    );
  }

  Color coloreNumero() {
    if (context.watch<timer_provider>().count_startato == 1) {
      if (context.watch<timer_provider>().tempo_secondi == 5) {
        return Colors.red;
      }
      if (context.watch<timer_provider>().tempo_secondi == 4) {
        return Colors.white;
      }
      if (context.watch<timer_provider>().tempo_secondi == 3) {
        return Colors.red;
      }
      if (context.watch<timer_provider>().tempo_secondi == 2) {
        return Colors.white;
      }
      if (context.watch<timer_provider>().tempo_secondi == 1) {
        return Colors.red;
      }
    }
    return Colors.white;
  }
}
