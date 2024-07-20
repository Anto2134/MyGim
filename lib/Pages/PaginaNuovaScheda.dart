// ignore_for_file: avoid_types_as_parameter_names

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
    tabData = widget.card.getMap();
    tabTitles = widget.card.getTab();
    tabs = widget.card.getTabs();
    tabController = TabController(length: tabTitles.length, vsync: this);
    Provider.of<nuovaScheda_provider>(context, listen: false)
        .addListener(_updateTabController);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Metodo per aggiornare il TabController
  void _updateTabController() {
    if (mounted) {
      setState(() {
        tabData = widget.card.getMap();
        tabTitles = widget.card.getTab();
        tabController.dispose();
        tabs = widget.card.getTabs();
        tabController = TabController(length: tabTitles.length, vsync: this);
      });
    }
  }

  void showFormDialog(BuildContext context, String titolo) {
    showDialog(
      context: context,
      builder: (context) {
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
    return widget.card.getTabs().map((tab) {
      return Tab(
        child: Card(
          color: Colors.black,
          child: Text(
            tab.getTitolo(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }).toList();
  }

  Widget returnBody() {
    return TabBarView(
        children: widget.card.getTabs().map(
      (tab) {
        return ListView.builder(
          itemCount: tab.getMap().length,
          itemBuilder: (context, index) {
            String sotto = tab.getMap().keys.toList()[index];
            List<String>? datiSotto = tab.getMap()[sotto];
            return SizedBox(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                color: Colors.black,
                child: Column(
                  children: [
                    Center(
                      child: ListTile(
                        title: Center(
                            child: Text(
                          sotto,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                        subtitle: Center(
                          child: Column(
                            children: datiSotto!.map((dato) {
                              return Text(
                                'serie: $dato',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).toList());
  }

  @override
  Widget build(BuildContext context) {
    int returnLength() {
      return widget.card.getTabs().length;
    }

    return DefaultTabController(
      length: returnLength(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.card.getNome(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            //volendo puoi raggruppare tutto in un unico floating action button
            Row(
              children: [
                const Text(
                  'Aggiungi uno split',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    _updateTabController();
                    showFormSplit(context);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.black, Colors.deepOrangeAccent])),
          child: Consumer<nuovaScheda_provider>(
            builder: (context, provider, _) {
              tab currentTab;
              return Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.deepOrange,
                    labelColor: Colors.black,
                    isScrollable: true,
                    onTap: (index) {
                      if (mounted) {
                        setState(() {
                          currentIndex = index;
                          currentTab = tabs[currentIndex];
                        });
                      }
                    },
                    tabs: returnTabs(),
                  ),
                  Expanded(
                    child: returnBody(),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            String currentTab = tabs[currentIndex].getTitolo();
            showFormDialog(context, currentTab);
          },
          child: const Icon(
            Icons.add_circle_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
