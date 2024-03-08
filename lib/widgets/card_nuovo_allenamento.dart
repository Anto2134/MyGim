// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_local_variable


import 'package:flutter/material.dart';

// ignore: must_be_immutable
class card_nuovo_allenamento extends StatefulWidget {
  card_nuovo_allenamento({super.key, required this.nome2nserie});
  Map<String, List<String>> nome2nserie = {};

  @override
  State<card_nuovo_allenamento> createState() => _card_nuovo_allenamentoState();
}

class _card_nuovo_allenamentoState extends State<card_nuovo_allenamento> {
  List<String> chiavi = [];
  List<String>? list = [];
  int nSerie = 1;

  @override
  Widget build(BuildContext context) {
    return lista();
  }


  int prendi() {
    chiavi = widget.nome2nserie.keys.toList();
    return chiavi.length;
  }

  String stampaLista(List<String> lista) {
    for (String s in lista) {
      return s;
    }
    return 'null';
  }

  int contaSerie() {
    for (String s in list!) {
      return nSerie++;
    }
    return 0;
  }

  Widget stampa(String nome_Esercizio) {
    for (String s in chiavi) {
      if (s == nome_Esercizio) {
        list = widget.nome2nserie[s];
        nSerie = contaSerie();
      }
    }
    return Column(
      children: list!.map((String item) {
        int n = 0;
        n = contaSerie();
        return Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text(
            '$n serie: $item',
            style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w700,fontSize: 15),
          ),
        );
      }).toList(),
    );
  }

  Widget lista() {
    return ListView.builder(
        itemCount: prendi(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          nSerie = 1;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 200,
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: ListTile(
                  subtitle: SizedBox(height: 140, child: stampa(chiavi[index])),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 125, bottom: 20),
                    child: Text('Esercizio: ${chiavi[index]}',
                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
