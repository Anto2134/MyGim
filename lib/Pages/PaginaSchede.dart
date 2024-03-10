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
        title: Text('le mie schede'),
      ),
      floatingActionButton: IconButton(
        color: Colors.red,
        onPressed: () {
          showFormDialog();
        },
        icon: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
      body: ListView.builder(
        itemCount: context.watch<nuovaScheda_provider>().schede.length,
        // itemCount: schede.length,
        itemBuilder: (context, index) {
          print(schede.length);
          return card_nuova_scheda(card: schede[index]);
          // return Card(
          //   color: Colors.black,
          //   child: ListTile(),
          // );
          // return card_nuova_scheda();
        },
      ),
    );
  }
}
