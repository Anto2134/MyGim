import 'package:flutter/material.dart';

class TabControllerProvider with ChangeNotifier {
  late TabController tabController;
  List<String> tabTitles = [];
  Map<String, List<String>> tabData = {};

  TabControllerProvider() {
    tabController =
        TabController(length: tabTitles.length, vsync: AnimatedListState());
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    // Aggiornare i dati del provider in base al tab attivo
    notifyListeners();
  }

  void addTab() {
    final newTabTitle = 'Tab ${tabTitles.length + 1}';
    tabTitles.add(newTabTitle);
    tabData[newTabTitle] = [];
    tabController =
        TabController(length: tabTitles.length, vsync: AnimatedListState());
    tabController.addListener(_onTabChanged);
    notifyListeners();
  }

  void addDataToTab(String tabTitle, String data) {
    tabData[tabTitle]?.add(data);
    notifyListeners();
  }
}
