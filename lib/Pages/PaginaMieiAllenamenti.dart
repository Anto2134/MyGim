// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovaSessione_provider.dart';
import 'package:progettomygimnuovo/providers/nuovoAllenamento_provider.dart';
import 'package:progettomygimnuovo/widgets/Widget_New_Training.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaMieiAllenamenti extends StatefulWidget {
  PaginaMieiAllenamenti({
    super.key,
  });
  int count_data = 0;

  @override
  State<PaginaMieiAllenamenti> createState() => _PaginaMieiAllenamentiState();

  //  void static; incrementa() {
  //   count_data++;
  // }
}

class _PaginaMieiAllenamentiState extends State<PaginaMieiAllenamenti> {
  final List<String> list = ['c1', 'c2'];
  List<String> dati = [];

  @override
  void initState() {
    super.initState();
    dati = context.read<nuovoAllenamento_provider>().date;
    // dati = context.read<nuovaSessione_provider>().dati;
    //Provider.of<nuovaSessione_provider>(context, listen: false).loadData();
    // loadData();
    // context.read<nuovaSessione_provider>().loadData();
  }

  void dismissCard(String id) {
    if (context.read<nuovoAllenamento_provider>().date.contains(id)) {
      setState(() {
        context.read<nuovoAllenamento_provider>().rimuovi(id);
      });
    }
  }

  // Future<void> saveData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('dati', dati);
  // }

  // Future<void> loadData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     dati = prefs.getStringList('dati') ?? [];
  //   });
  // }

  // void addItem(String newItem){
  //   setState(() {
  //     dati.add(newItem);
  //     saveData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<nuovoAllenamento_provider>(
        builder: (context, nuovoallenamentoProvider, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/prima');
                      // context.read<nuovaSessione_provider>().rimuovi();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
              ),
              // body: context.watch<nuovaSessione_provider>().list,
              body: ListView.builder(
                // key: UniqueKey(),
                itemCount:
                    context.read<nuovoAllenamento_provider>().date.length,
                // itemBuilder: (context, index) {
                //   // return Widget_New_Training(category: list[index]);
                //   return Card(
                //     child: ListTile(
                //       title: Text(context
                //           .read<nuovoAllenamento_provider>()
                //           .date[index]),
                //       trailing: Text('$index'),
                //     ),
                //   );
                // },
                itemBuilder: (context, index) {
                  // final card = nuovoallenamentoProvider.date[index];
                  final card =
                      context.read<nuovoAllenamento_provider>().date[index];
                  return Dismissible(
                    key: Key(card),
                    // key: UniqueKey(),
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
                              for (String s in context
                                  .read<nuovoAllenamento_provider>()
                                  .date) {
                                return SubCategoryPage(category: s);
                              }
                              return const CircularProgressIndicator(
                                backgroundColor: Colors.red,
                              );
                            },
                            // builder: (context) =>
                            //     SubCategoryPage(category: 'ciao'),
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

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         leading: IconButton(
  //             onPressed: () {
  //               Navigator.pushNamed(context, '/prima');
  //             },
  //             icon: const Icon(
  //               Icons.arrow_back,
  //               color: Colors.black,
  //             )),
  //       ),
  //       // body: context.watch<nuovaSessione_provider>().list,
  //       body: ListView.builder(
  //         // itemCount: dati.length,
  //         itemCount: context.read<nuovaSessione_provider>().dati.length,
  //         // itemCount: nuovaSessione_provider().dati.length,
  //         // itemCount:1,
  //         itemBuilder: (context, index) {
  //           // return Widget_New_Training(category: list[index]);
  //           return Widget_New_Training();
  //         },
  //       ),
  //     ),
  //   );
  // }
}

// class CardWidget extends StatefulWidget {
//   final String category;

//   CardWidget({required this.category});

//   @override
//   State<CardWidget> createState() => _CardWidgetState();
// }

// class _CardWidgetState extends State<CardWidget> {
//   String data = "";
//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       data = prefs.getString('nomeEsercizio') ?? "";
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(widget.category),
//         trailing: Text('$data'),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SubCategoryPage(category: widget.category),
//             ),
//           );
//         },
//       ),
//     );
// }
// }

class SubCategoryPage extends StatelessWidget {
  final String category;
  final List<String> subCategories = [
    'Subcategoria 1',
    'Subcategoria 2',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
    'Subcategoria 3',
  ];

  SubCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(subCategories[index]),
              // Aggiungi azioni o navigazione per la sottocategoria qui
            ),
          );
        },
      ),
    );
  }
}

//per prendere la data del nuovo allenamento posso prenderla nel momento in cui clicco su nuovo allenamento
//per incrementare il numero di allenamenti sfrutta una variabile collegata al provider