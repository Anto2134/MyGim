// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:progettomygimnuovo/providers/nuovaScheda_provider.dart';
// import 'package:progettomygimnuovo/widgets/scheda.dart';
// import 'package:provider/provider.dart';

// class PaginaNuovaScheda extends StatefulWidget {
//   final scheda card;
//   const PaginaNuovaScheda({super.key, required this.card});

//   @override
//   State<PaginaNuovaScheda> createState() => _PaginaNuovaSchedaState();
// }

// class _PaginaNuovaSchedaState extends State<PaginaNuovaScheda>
//     with TickerProviderStateMixin {
//   late TabController tabController;
// List<String> tabTitles = [];
// Map<String, List<String>> tabData = {};

//   @override
//   void initState() {
//     super.initState();
//     tabData = context.read<nuovaScheda_provider>().tab2esercizio;
//     tabTitles = context.read<nuovaScheda_provider>().tabTitles;
//     // tabController = TabController(length: widget.card.getGiorni(), vsync: this);
//     tabController = TabController(length: tabTitles.length, vsync: this);
//   }

//   // void addTab(String title) {
//   //   setState(() {
//   //     context.read<nuovaScheda_provider>().addTab(title);
//   //     tabController = TabController(length: tabTitles.length, vsync: this);
//   //   });
//   // }

//   void addDataToTab(String title, String data) {
//     setState(() {
//       tabData[title]?.add(data);
//     });
//   }

//   void showFormDialog(String titolo) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         context.read<nuovaScheda_provider>().setContext(context);
//         return context.read<nuovaScheda_provider>().generaForm2(titolo);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           TextButton(
//             onPressed: () {
//               Provider.of<nuovaScheda_provider>(context, listen: false).addTab();
//               // context.read<nuovaScheda_provider>().addTab();
//               // addTab('Tab ${tabTitles.length + 1}');
//               // addDataToTab('Tab ${tabTitles.length}', 'Dato aggiunto');
//             },
//             child: Text(
//               'Aggiungi un nuovo split',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//         title: Text('Tab dinamico'),
//         bottom: TabBar(
//           controller: tabController,
//           tabs: context
//               .read<nuovaScheda_provider>()
//               .tabTitles
//               .map((title) => Tab(text: title))
//               .toList(),
//         ),
//       ),
//       body: TabBarView(
//         controller: tabController,
//         children: context.read<nuovaScheda_provider>().tabTitles.map((title) {
//           final tabData =
//               context.read<nuovaScheda_provider>().tab2esercizio[title] ?? [];
//           return ListView.builder(
//             // itemCount: tabData[title]?.length ?? 0,
//             // itemCount: context.read<nuovaScheda_provider>().tab2esercizio.length,
//             itemCount: tabData.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(tabData[index]),
//                 // title: Text(context.read<nuovaScheda_provider>().tab2esercizio[index]),
//                 // title: Text(context
//                         // .read<nuovaScheda_provider>()
//                         // .tab2esercizio[title]?[index] ??
//                     // ''),
//               );
//             },
//           );
//         }).toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           String currentTab = tabTitles[tabController.index];
//           showFormDialog(currentTab);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovaScheda_provider.dart';
import 'package:progettomygimnuovo/widgets/scheda.dart';
import 'package:provider/provider.dart';

class PaginaNuovaScheda extends StatefulWidget {
  final scheda card;
  const PaginaNuovaScheda({Key? key, required this.card}) : super(key: key);

  @override
  State<PaginaNuovaScheda> createState() => _PaginaNuovaSchedaState();
}

class _PaginaNuovaSchedaState extends State<PaginaNuovaScheda>
    with TickerProviderStateMixin {
  List<String> tabTitles = [];
  Map<String, List<String>> tabData = {};
  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabData = context.read<nuovaScheda_provider>().tab2esercizio;
    tabTitles = context.read<nuovaScheda_provider>().tabTitles;
    tabController = TabController(length: tabTitles.length, vsync: this);
    Provider.of<nuovaScheda_provider>(context, listen: false)
        .addListener(_updateTabController);
  }

  // @override
  void dispose() {
    // Rimuovi il listener prima di disporre dello stato
    // Provider.of<nuovaScheda_provider>(context, listen: false)
    //     .removeListener(_updateTabController);
    // Disponi il TabController
    tabController.dispose();
    super.dispose();
  }

  // Metodo per aggiornare il TabController
  void _updateTabController() {
    if (mounted) {
      setState(() {
        tabData = context.read<nuovaScheda_provider>().tab2esercizio;
        tabTitles = context.read<nuovaScheda_provider>().tabTitles;
        tabController.dispose();
        // Aggiorna il TabController con il nuovo numero di tab
        tabController = TabController(length: tabTitles.length, vsync: this);
      });
    }
  }

  void showFormDialog(BuildContext context, String titolo) {
    showDialog(
      context: context,
      builder: (context) {
        context.read<nuovaScheda_provider>().setContext(context);
        return context.read<nuovaScheda_provider>().generaForm2(titolo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: context.read<nuovaScheda_provider>().tabTitles.length,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Tab dinamico'),
          actions: [
            IconButton(
              onPressed: () {
                _updateTabController();
                Provider.of<nuovaScheda_provider>(context, listen: false)
                    .addTab();
                // int currentIndex = DefaultTabController.of(context).index;
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Consumer<nuovaScheda_provider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                TabBar(
                  onTap: (index) {
                    if (mounted) {
                      setState(() {
                        currentIndex = index;
                        print(currentIndex);
                        print(index);
                      });
                    }
                  },
                  // controller: tabController,
                  tabs: provider.tabTitles
                      .map((title) => Tab(text: title))
                      .toList(),
                ),
                Expanded(
                  child: TabBarView(
                    // controller: tabController,
                    children: provider.tabTitles.map((title) {
                      final tabDataa = provider.tab2esercizio[title] ?? [];
                      return ListView.builder(
                        // itemCount: provider.tab2esercizio[title]!.length,
                        // itemCount: tabTitles[].length,
                        // itemCount: tabData[title]!.length,
                        itemCount: tabDataa.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(tabDataa[index]),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // int currentIndex = DefaultTabController.of(context).index;
            // int currentIndex = DefaultTabController.of(context)?.index ?? 0;
            // int currentIndex = context.read<nuovaScheda_provider>().tabController.index;
            // String currentTab = context.read<nuovaScheda_provider>().tabTitles[currentIndex];
            // int currentIndex = tabController.index;
            print('current + $currentIndex');
            String currentTab = tabTitles[currentIndex];
            showFormDialog(context, currentTab);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
