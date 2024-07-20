// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovaScheda_provider.dart';
import 'package:progettomygimnuovo/widgets/card_nuova_scheda.dart';
import 'package:provider/provider.dart';

import '../widgets/scheda.dart';

class PaginaSchede extends StatefulWidget {
  @override
  State<PaginaSchede> createState() => _PaginaSchedeState();
}

class _PaginaSchedeState extends State<PaginaSchede> {
  List<scheda> schede = [];

  @override
  void initState() {
    schede = context.read<nuovaScheda_provider>().schede;
    super.initState();
  }

  Future<void> loadSchede() async {
    schede = await context.read<nuovaScheda_provider>().loadData();
  }

  void showFormDialog() {
    showDialog(
      context: context,
      builder: (context) {
        context.read<nuovaScheda_provider>().setContext(context);
        return context.read<nuovaScheda_provider>().generaForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Le mie schede',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormDialog();
        },
        backgroundColor: Colors.amberAccent[400],
        child: const Icon(
          Icons.add_to_photos_sharp,
          color: Colors.black,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.black, Colors.amber])),
        child: ListView.builder(
          itemCount: context.watch<nuovaScheda_provider>().schede.length,
          itemBuilder: (context, index) {
            var schedaItem = context.watch<nuovaScheda_provider>().schede[index];
            return Dismissible(
              key: Key(schedaItem.id.toString()), // Assicurati di usare un identificatore univoco
              onDismissed: (direction) {
                // Rimuovi la scheda
                context.read<nuovaScheda_provider>().removeScheda(schedaItem);
                // Opzionalmente mostra un messaggio
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${schedaItem.nome} cancellata"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              child: card_nuova_scheda(card: schedaItem),
            );
          },
        ),
      ),
    );
  }
}
