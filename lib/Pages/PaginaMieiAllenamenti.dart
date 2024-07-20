// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovoAllenamento_provider.dart';
import 'package:provider/provider.dart';

class PaginaMieiAllenamenti extends StatefulWidget {
  const PaginaMieiAllenamenti({
    super.key,
  });

  @override
  State<PaginaMieiAllenamenti> createState() => _PaginaMieiAllenamentiState();
}

class _PaginaMieiAllenamentiState extends State<PaginaMieiAllenamenti> {
  List<String> dati = [];
  Map<String, Map<String, List<String>>> orario2ese = {};

  @override
  void initState() {
    super.initState();
    orario2ese = context.read<nuovoAllenamento_provider>().orario2ese;
    for (String s in orario2ese.keys) {
      dati.add(s);
    }
  }

  void dismissCard(String id) {
    if (context.read<nuovoAllenamento_provider>().orario2ese.containsKey(id)) {
      setState(() {
        dati.remove(id);
        context.read<nuovoAllenamento_provider>().deleteMap(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<nuovoAllenamento_provider>(
        builder: (context, nuovoallenamentoProvider, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Allenamenti',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/prima');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    )),
              ),
              body: Container(
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.black, Colors.blue])),
                child: ListView.builder(
                  itemCount: dati.length,
                  itemBuilder: (context, index) {
                    final card = dati[index];
                    return Dismissible(
                      key: Key(card),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        dismissCard(card);
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SubCategoryPage(
                                    category: card,
                                    map: orario2ese,
                                    indice: index,
                                  );
                                },
                              ),
                            );
                          },
                          title: Text(
                            'Allenamento ${index + 1} ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            "creato il:$card",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ));
  }
}

class SubCategoryPage extends StatefulWidget {
  final String category;
  final Map<String, Map<String, List<String>>> map;
  final int indice;

  const SubCategoryPage(
      {super.key,
      required this.category,
      required this.map,
      required this.indice});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  List<String> esercizi = [];
  Map<String, List<String>>? app = {};
  List<String>? dati = [];
  int nSerie = 0;

  int numeroElementi() {
    Map<String, List<String>>? app = widget.map[widget.category];
    esercizi = app!.keys.toList();
    return esercizi.length;
  }

  String elemento(String nomeEsercizio) {
    Map<String, List<String>>? app = widget.map[widget.category];
    for (String s in esercizi) {
      if (s == nomeEsercizio) {
        return app![s].toString();
      }
    }
    return 'null';
  }

  int numeroSerie() {
    for (String s in dati!) {
      return nSerie++;
    }
    return 0;
  }

  Widget stampa(String n) {
    Map<String, List<String>>? app = widget.map[widget.category];
    for (String s in esercizi) {
      if (s == n) {
        dati = app![s];
        nSerie = numeroSerie();
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dati!.map((String item) {
        int n = 0;
        n = numeroSerie();
        return Flexible(
          fit: FlexFit.tight,
          flex: 0,
          child: Text(
            '$n serie: $item',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Allenamento ${widget.indice + 1}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.blue, Colors.black])),
        child: ListView.builder(
          itemCount: numeroElementi(),
          itemBuilder: (context, index) {
            nSerie = 1;
            return SizedBox(
              height: 280,
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  // title: Text(esercizi[index]),
                  title: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      esercizi[index],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: SizedBox(
                    height: 190,
                    child: stampa(esercizi[index]),
                  ),
                  trailing: Text(elemento(esercizi[index])),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
