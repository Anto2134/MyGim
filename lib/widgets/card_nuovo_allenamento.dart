// // ignore_for_file: non_constant_identifier_names, camel_case_types, unused_local_variable


import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class card_nuovo_allenamento extends StatefulWidget {
//   card_nuovo_allenamento({super.key, required this.nome2nserie});
//   Map<String, List<String>> nome2nserie = {};

//   @override
//   State<card_nuovo_allenamento> createState() => _card_nuovo_allenamentoState();
// }

// class _card_nuovo_allenamentoState extends State<card_nuovo_allenamento> {
//   List<String> chiavi = [];
//   List<String>? list = [];
//   int nSerie = 1;

//   @override
//   Widget build(BuildContext context) {
//     return lista();
//   }


//   int prendi() {
//     chiavi = widget.nome2nserie.keys.toList();
//     return chiavi.length;
//   }

//   String stampaLista(List<String> lista) {
//     for (String s in lista) {
//       return s;
//     }
//     return 'null';
//   }

//   int contaSerie() {
//     for (String s in list!) {
//       return nSerie++;
//     }
//     return 0;
//   }

//   Widget stampa(String nome_Esercizio) {
//     for (String s in chiavi) {
//       if (s == nome_Esercizio) {
//         list = widget.nome2nserie[s];
//         nSerie = contaSerie();
//       }
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: list!.map((String item) {
//         int n = 0;
//         n = contaSerie();
//         return Flexible(
//           fit: FlexFit.tight,
//           flex: 0,
//           child: Text(
//             '$n serie: $item',
//             style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget lista() {
//     return ListView.builder(
//         itemCount: prendi(),
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           nSerie = 1;
//           return Padding(
//             padding: const EdgeInsets.all(10),
//             child: SizedBox(
//               height: 200,
//               child: Card(
//                 color: Colors.black,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50)),
//                 child: ListTile(
//                   subtitle: SizedBox(height: 180, child: stampa(chiavi[index])),
//                   title: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Text('Esercizio: ${chiavi[index]}',
//                         style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 23)),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
class card_nuovo_allenamento extends StatefulWidget {
  final Map<String, List<String>> nome2nserie;

  const card_nuovo_allenamento({super.key, required this.nome2nserie});

  @override
  State<card_nuovo_allenamento> createState() => _card_nuovo_allenamentoState();
}

class _card_nuovo_allenamentoState extends State<card_nuovo_allenamento> {
  @override
  Widget build(BuildContext context) {
    final List<String> chiavi = widget.nome2nserie.keys.toList();

    return ListView.builder(
      itemCount: chiavi.length,
      itemBuilder: (context, index) {
        final String chiave = chiavi[index];
        final List<String>? list = widget.nome2nserie[chiave];
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Esercizio: $chiave',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: list != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: list.asMap().entries.map((entry) {
                          int serieNumber = entry.key + 1;
                          String item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Serie $serieNumber: $item',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}