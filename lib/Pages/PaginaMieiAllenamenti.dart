// ignore_for_file: must_be_immutable

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
  final List<String> list = ['c1', 'c2'];
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

  Future<void> loadMap() async {
    orario2ese = await context.read<nuovoAllenamento_provider>().loadMap();
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
                backgroundColor: Colors.black,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/prima');
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
              ),
              body: ListView.builder(
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
                      title: Text('Allenamento ${index + 1} '),
                      trailing: Text("creato il:" + card),
                    ),
                  );
                },
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
      body: ListView.builder(
        itemCount: numeroElementi(),
        itemBuilder: (context, index) {
          nSerie = 1;
          return SizedBox(
            height: 280,
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
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
    );
  }
}

//per prendere la data del nuovo allenamento posso prenderla nel momento in cui clicco su nuovo allenamento
//per incrementare il numero di allenamenti sfrutta una variabile collegata al provider
