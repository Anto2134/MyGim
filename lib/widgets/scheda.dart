import 'package:flutter/foundation.dart';

import 'tab.dart';

class scheda {
  String nome = '';
  int numeroGiorni = 0;
  // Map<String, int> esercizi2nSerie = {};
  // Map<String, List<String>> esercizi2nSerie = {};
  Map<String, List<String>> tab2esercizi = {};
  Map<String, List<String>> nome2serie = {};
  Map<String, Map<String, List<String>>> map = {};
  List<String> tabTitles = [];
  List<tab> tabs = [];

  scheda() {
    tabs = [];
  }

  // Map<String, List<String>> getNome2serie(){
  //   return this.nome2serie;
  // }

  Map<String, List<String>>? getMapF(String title) {
    print('mappa associata' + map[title].toString());
    return map[title];
  }

  void setF(Map<String, Map<String, List<String>>> map) {
    this.map = map;
  }

  // void reset(String tab){
  //   map[tab] = {};
  //   List<String> app = [];
  //   nome2serie[''] = app;
  // }

  // List<String>? getEse(String esercizio) {
  //   return nome2serie[esercizio];
  // }

  Map<String, Map<String, List<String>>> getMaps() {
    print('la mappa' + map.toString());
    return map;
  }

  // void setNome2serie(Map<String, List<String>> nome2nserie) {
  //   this.nome2serie = nome2nserie;
  // }

  void setNome(String nome) {
    this.nome = nome;
  }

  void setGiorni(int numeroGiorni) {
    this.numeroGiorni = numeroGiorni;
  }

  void setTab(List<String> tabTitles) {
    this.tabTitles = tabTitles;
  }

  // void setMap(Map<String, int> esercizi2nSerie) {
  //   this.esercizi2nSerie = esercizi2nSerie;
  // }

  void setMap(Map<String, List<String>> tab2esercizi) {
    this.tab2esercizi = tab2esercizi;
  }

  void setDati(String tab, Map<String, List<String>> dati) {
    map[tab] = dati;
  }

  // void setData(String tab, String esercizio, String serie) {
  //   // if (tabTitles.length > 1) {
  //   //   // nome2serie.clear();
  //   //   map[tab]!.clear();
  //   // }
  //   // for (String s in tabTitles) {
  //   //   if (s == tab) {
  //       nome2serie[esercizio] = [];
  //       nome2serie[esercizio]?.add(serie);
  //       // map[tab] = {};
  //       print('map2' + nome2serie.toString() + tab);
  //       map[tab] = nome2serie;
  //     // }
  //   // }
  //   print('map =' + map[tab].toString());
  //   print('aggiunti');
  // }

  // void addDati(String tab, String dati) {
  //   tab2esercizi[tab]?.add(dati);
  //   print('dati' + tab2esercizi.toString());
  // }

  List<String> getTab() {
    return this.tabTitles;
  }

  List<tab> getTabs() {
    return this.tabs;
  }

  void addNewTab(String titolo) {
    tab nuovo = new tab(titolo);
    tabs.add(nuovo);
    print('tab in new' + tabs.toString());
  }

  void addDati(String titolo, String nomeEsercizio, String serie) {
    // print('tabs in dati' + tabs.toString());
    print('title'+titolo);
    for (tab t in tabs) {
      print('tabs' + t.getTitolo());
      if (titolo == t.getTitolo()) {
        print('aggiunti');
        t.setData(nomeEsercizio, serie);
      }
    }
  }

  void addTab(String title) {
    // final title = 'Tab ${tabTitles.length + 1}';
    tabTitles.add(title);
    // map[title]!.clear();
    // nome2serie = {};
    // nome2serie.clear();
    map[title] = {};
    // Map<String, List<String>>
    String app = '';
    List<String> listapp = [];
    Map<String, List<String>> mapap = {};
    mapap[app] = listapp;
    // nome2serie[app] = [];
    // nome2serie = {};
    map[title] = mapap;
    // tab2esercizi[title] = [];
  }

  String getNome() {
    return this.nome;
  }

  int getGiorni() {
    return this.numeroGiorni;
  }

  Map<String, List<String>> getMap() {
    return this.tab2esercizi;
  }

  factory scheda.fromJson(Map<String, dynamic> json) {
    return scheda()
      ..nome = json['nome']
      ..numeroGiorni = json['numeroGiorni']
      // ..esercizi2nSerie = json['esercizi2nSerie'];
      ..tab2esercizi = json['esercizi2nSerie'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'numeroGiorni': numeroGiorni,
      // 'esercizi2nSerie' : esercizi2nSerie,
      'esercizi2nSerie': tab2esercizi,
    };
  }
}
