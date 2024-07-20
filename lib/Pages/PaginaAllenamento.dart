import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovoAllenamento_provider.dart';
import 'package:provider/provider.dart';

class PaginaAllenamento extends StatefulWidget {
  const PaginaAllenamento({super.key});

  @override
  State<PaginaAllenamento> createState() => _PaginaAllenamentoState();
}

class _PaginaAllenamentoState extends State<PaginaAllenamento> {
  int numeroCard = 0;
  String nomeEsercizio = '';
  late DateTime sessionStartTime;
  int toccato = 0;

  @override
  void initState() {
    super.initState();
    sessionStartTime = DateTime.now();
  }

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: context.watch<nuovoAllenamento_provider>().generaForm(),
            ),
          ),
        );
      },
    );
  }

  //se non hai ancora cliccato la spunta non devi far uscire chiudi quindi metti un counter, 
  //se invece hai già premuto la spunta la fai sparire e fai comparire solo chiudi

  void _showStartSessionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Inizia Sessione",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Vuoi iniziare una nuova sessione?"),
          actions: [
            TextButton(
              onPressed: () {
                toccato = 0;
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                context.read<nuovoAllenamento_provider>().startSession();
                Navigator.of(context).pop();
              },
              child: const Text('Si'),
            ),
          ],
        );
      },
    );
  }

  Widget? _buildBody() {
    if (context.read<nuovoAllenamento_provider>().isSessionActive) {
      return context.watch<nuovoAllenamento_provider>().list_v;
    }
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Text(
          'AVVIA LA SESSIONE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 5,
          centerTitle: true,
          title: const Text(
            'Allenamento',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/prima');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              onPressed: () {
                if (toccato == 0) {
                  toccato++;
                  _showStartSessionDialog();
                }
              },
            ),
            const SizedBox(height: 20),
            context.watch<nuovoAllenamento_provider>().isSessionActive
                ? TextButton(
                    onPressed: () {
                      toccato = 0;
                      context.read<nuovoAllenamento_provider>().endSession();
                    },
                    child: const Text(
                      'END',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _buildBody(),
        ),
        floatingActionButton: context
                .watch<nuovoAllenamento_provider>()
                .isSessionActive
            ? FloatingActionButton(
                onPressed: () async {
                  context.read<nuovoAllenamento_provider>().setContext(context);
                  context.read<nuovoAllenamento_provider>().azzera();
                  numeroCard++;
                  context
                      .read<nuovoAllenamento_provider>()
                      .setNEsercizi(numeroCard);
                  _showFormDialog();
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
