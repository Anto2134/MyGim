import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/nuovaScheda_provider.dart';
import 'package:progettomygimnuovo/widgets/scheda.dart';
import 'package:provider/provider.dart';

import '../widgets/tab.dart';

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
  List<String> chiavi = [];
  List<tab> tabs = [];

  @override
  void initState() {
    super.initState();
    // if (widget.card.getTab().isEmpty) {
    //   tabData = context.read<nuovaScheda_provider>().tab2esercizio;
    //   tabTitles = context.read<nuovaScheda_provider>().tabTitles;
    //   tabController = TabController(length: tabTitles.length, vsync: this);
    //   Provider.of<nuovaScheda_provider>(context, listen: false)
    //       .addListener(_updateTabController);
    // } else {
    tabData = widget.card.getMap();
    tabTitles = widget.card.getTab();
    tabs = widget.card.getTabs();
    tabController = TabController(length: tabTitles.length, vsync: this);
    Provider.of<nuovaScheda_provider>(context, listen: false)
        .addListener(_updateTabController);
    // }
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
        // if (widget.card.tabTitles.isEmpty) {
        //   tabData = context.read<nuovaScheda_provider>().tab2esercizio;
        //   tabTitles = context.read<nuovaScheda_provider>().tabTitles;
        //   tabController.dispose();
        //   // Aggiorna il TabController con il nuovo numero di tab
        //   tabController = TabController(length: tabTitles.length, vsync: this);
        // } else {
        tabData = widget.card.getMap();
        tabTitles = widget.card.getTab();
        tabController.dispose();
        tabs = widget.card.getTabs();

        tabController = TabController(length: tabTitles.length, vsync: this);
        // }
      });
    }
  }

  void showFormDialog(BuildContext context, String titolo) {
    showDialog(
      context: context,
      builder: (context) {
        // context.read()<nuovaScheda_provider>().azzera();
        context.read<nuovaScheda_provider>().setContext(context);
        return context
            .read<nuovaScheda_provider>()
            .generaForm2(titolo, widget.card);
      },
    );
  }

  void showFormSplit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        context.read<nuovaScheda_provider>().setContext(context);
        return context.read<nuovaScheda_provider>().generaFormTab(widget.card);
      },
    );
  }

  int prendi(String tab) {
    Map<String, List<String>>? app = widget.card.getMapF(tab);
    chiavi = app!.keys.toList();
    return app.length;
  }

  List<Widget> returnTabs() {
    // if (widget.card.getTab().isNotEmpty) {
    return widget.card
        .getTabs()
        .map((tab) => Tab(text: tab.getTitolo()))
        .toList();
    // return widget.card.getMaps().keys.map(
    //   (String tab) {
    //     return Tab(text: tab);
    //   },
    // ).toList();
    // } else {
    //   return context
    //       .read<nuovaScheda_provider>()
    //       .tabTitles
    //       .map((title) => Tab(text: title))
    //       .toList();
    // }
  }

  // Widget stampa(String nomeEs){
  //   for(String s in )
  // }

  Widget returnBody() {
    // if (widget.card.getTab().isNotEmpty) {
    // return TabBarView(
    //     children: widget.card.getTab().map(
    //   (title) {
    //     Map<String, List<String>> app = widget.card.getMap();
    //     final tabDataa = app[title] ?? [];
    //     return ListView.builder(
    //       itemCount: tabDataa.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //             title: Text(
    //           tabDataa[index],
    //           style: TextStyle(color: Colors.red),
    //         ));
    //       },
    //     );
    //   },
    return TabBarView(
        children: widget.card.getTabs().map(
      (tab) {
        return ListView.builder(
          itemCount: tab.getMap().length,
          itemBuilder: (context, index) {
            String sotto = tab.getMap().keys.toList()[index];
            return ListTile(
              title: Text(sotto),
            );
          },
        );
      },
    ).toList());
    // ).toList());
    // Map<String, Map<String, List<String>>> mappa = widget.card.getMaps();
    // return TabBarView(
    //     // children: widget.card.getTab().map(
    //     children: mappa.keys.map(
    //   (String title) {
    //     Map<String, List<String>>? mappa2 = mappa[title];
    //     return ListView(
    //         children: mappa2!.keys.map(
    //       (String esercizio) {
    //         List<String>? esercizi = mappa2[esercizio];
    //         return ListTile(
    //           title: Text(esercizio),
    //           subtitle: Column(
    //             children: esercizi!.map((String dato) {
    //               return Text(dato);
    //             }).toList(),
    //           ),
    //         );
    //       },
    //     ).toList(growable: true));
    //   },
    // ).toList(growable: true));
    // return TabBarView(children: mappa.keys.map((String title) {
    //   // Map<String, List<String>>? mappa2 = mappa[title];
    //   return ListView.builder(itemCount: mappa[title]!.length,itemBuilder: (context, index) {
    //     String sotto = mappa[title]!.keys.toList()[index];
    //     List<String> dati = mappa[title]![sotto]!;
    //     return ListTile(title: Text(sotto),);
    //   },);
    // },).toList());
  }

  @override
  Widget build(BuildContext context) {
    int returnLength() {
      return widget.card.getTabs().length;
    }

    return DefaultTabController(
      length: returnLength(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Tab dinamico'),
          actions: [
            IconButton(
              onPressed: () {
                // widget.card.addTab();
                _updateTabController();
                // Provider.of<nuovaScheda_provider>(context, listen: false)
                // .addTab(widget.card);
                // widget.card.addTab();
                showFormSplit(context);
                // widget.card
                // widget.card.setTab(tabTitles);
                // Provider.of<nuovaScheda_provider>(context, listen: false)
                // .addTab();
                // int currentIndex = DefaultTabController.of(context).index;
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Consumer<nuovaScheda_provider>(
          builder: (context, provider, _) {
            // String currentTab = "";
            tab currentTab;
            return Column(
              children: [
                TabBar(
                  isScrollable: true,
                  onTap: (index) {
                    if (mounted) {
                      setState(() {
                        currentIndex = index;
                        currentTab = tabs[currentIndex];
                        // currentTab = tabTitles[currentIndex];
                        print(currentIndex);
                        print(index);
                      });
                    }
                  },
                  // controller: tabController,
                  // tabs: provider.tabTitles
                  //     .map((title) => Tab(text: title))
                  //     .toList(),
                  tabs: returnTabs(),
                ),
                Expanded(
                  child: returnBody(),
                  // child: TabBarView(
                  //   // controller: tabController,
                  //   children: provider.tabTitles.map((title) {
                  //     // final tabDataa = provider.tab2esercizio[title] ?? [];
                  // Map<String, List<String>> app = widget.card.getMap();
                  // final tabDataa = app[title] ?? [];
                  //     return ListView.builder(
                  //       // itemCount: provider.tab2esercizio[title]!.length,
                  //       // itemCount: tabTitles[].length,
                  //       // itemCount: tabData[title]!.length,
                  //       itemCount: tabDataa.length,
                  //       itemBuilder: (context, index) {
                  //         return ListTile(
                  //           title: Text(tabDataa[index]),
                  //         );
                  //       },
                  //     );
                  //   }).toList(),
                  // ),
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
            // String currentTab = tabTitles[currentIndex];
            String currentTab = tabs[currentIndex].getTitolo();
            showFormDialog(context, currentTab);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
