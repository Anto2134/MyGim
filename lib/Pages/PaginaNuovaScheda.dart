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
    if (widget.card.getTab().isEmpty) {
      tabData = context.read<nuovaScheda_provider>().tab2esercizio;
      tabTitles = context.read<nuovaScheda_provider>().tabTitles;
      tabController = TabController(length: tabTitles.length, vsync: this);
      Provider.of<nuovaScheda_provider>(context, listen: false)
          .addListener(_updateTabController);
    } else {
      tabData = widget.card.getMap();
      tabTitles = widget.card.getTab();
      tabController = TabController(length: tabTitles.length, vsync: this);
      Provider.of<nuovaScheda_provider>(context, listen: false)
          .addListener(_updateTabController);
    }
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
        if (widget.card.tabTitles.isEmpty) {
          tabData = context.read<nuovaScheda_provider>().tab2esercizio;
          tabTitles = context.read<nuovaScheda_provider>().tabTitles;
          tabController.dispose();
          // Aggiorna il TabController con il nuovo numero di tab
          tabController = TabController(length: tabTitles.length, vsync: this);
        } else {
          tabData = widget.card.getMap();
          tabTitles = widget.card.getTab();
          tabController.dispose();
          tabController = TabController(length: tabTitles.length, vsync: this);
        }
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

  List<Widget> returnTabs() {
    if (widget.card.getTab().isNotEmpty) {
      return widget.card.getTab().map((title) => Tab(text: title)).toList();
    } else {
      return context
          .read<nuovaScheda_provider>()
          .tabTitles
          .map((title) => Tab(text: title))
          .toList();
    }
  }

  Widget returnBody() {
    if (widget.card.getTab().isNotEmpty) {
      return TabBarView(
          children: widget.card.getTab().map(
        (title) {
          Map<String, List<String>> app = widget.card.getMap();
          final tabDataa = app[title] ?? [];
          return ListView.builder(
            itemCount: tabDataa.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(tabDataa[index]));
            },
          );
        },
      ).toList());
    } else {
      return TabBarView(
        children: context.read<nuovaScheda_provider>().tabTitles.map((title) {
          final tabDataa =
              context.read<nuovaScheda_provider>().tab2esercizio[title] ?? [];
          return ListView.builder(
            itemCount: tabDataa.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tabDataa[index]),
              );
            },
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int returnLength() {
      if (widget.card.getTab().length != 0) {
        return widget.card.getTab().length;
      } else {
        return context.read<nuovaScheda_provider>().tabTitles.length;
      }
    }

    return DefaultTabController(
      // length: context.read<nuovaScheda_provider>().tabTitles.length,
      length: returnLength(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Tab dinamico'),
          actions: [
            IconButton(
              onPressed: () {
                widget.card.addTab();
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
            String currentTab = "";
            return Column(
              children: [
                TabBar(
                  onTap: (index) {
                    if (mounted) {
                      setState(() {
                        currentIndex = index;
                        currentTab = tabTitles[currentIndex];
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
            String currentTab = tabTitles[currentIndex];
            showFormDialog(context, currentTab);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
