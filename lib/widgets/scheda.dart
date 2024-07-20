import 'dart:math';

import 'package:flutter/foundation.dart';

import 'tab.dart';

class scheda {
  String nome = '';
  int numeroGiorni = 0;
  Map<String, List<String>> tab2esercizi = {};
  Map<String, List<String>> nome2serie = {};
  Map<String, Map<String, List<String>>> map = {};
  List<String> tabTitles = [];
  List<tab> tabs = [];
  late int id;
  int max = 30;

  scheda() {
    tabs = [];
    id = Random().nextInt(max);
  }

  Map<String, List<String>>? getMapF(String title) {
    return map[title];
  }

  void setF(Map<String, Map<String, List<String>>> map) {
    this.map = map;
  }

  Map<String, Map<String, List<String>>> getMaps() {
    return map;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  void setGiorni(int numeroGiorni) {
    this.numeroGiorni = numeroGiorni;
  }

  void setTab(List<String> tabTitles) {
    this.tabTitles = tabTitles;
  }

  void setMap(Map<String, List<String>> tab2esercizi) {
    this.tab2esercizi = tab2esercizi;
  }

  void setDati(String tab, Map<String, List<String>> dati) {
    map[tab] = dati;
  }

  List<String> getTab() {
    return tabTitles;
  }

  List<tab> getTabs() {
    return tabs;
  }

  void addNewTab(String titolo) {
    tab nuovo = tab(titolo);
    tabs.add(nuovo);
  }

  void addDati(String titolo, String nomeEsercizio, String serie) {
    for (tab t in tabs) {
      if (titolo == t.getTitolo()) {
        t.setData(nomeEsercizio, serie);
      }
    }
  }

  void addTab(String title) {
    tabTitles.add(title);
    map[title] = {};
    String app = '';
    List<String> listapp = [];
    Map<String, List<String>> mapap = {};
    mapap[app] = listapp;
    map[title] = mapap;
  }

  String getNome() {
    return nome;
  }

  int getGiorni() {
    return numeroGiorni;
  }

  Map<String, List<String>> getMap() {
    return tab2esercizi;
  }

  factory scheda.fromJson(Map<String, dynamic> json) {
    return scheda()
      ..nome = json['nome']
      ..numeroGiorni = json['numeroGiorni']
      ..tab2esercizi = json['esercizi2nSerie'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'numeroGiorni': numeroGiorni,
      'esercizi2nSerie': tab2esercizi,
    };
  }
}
