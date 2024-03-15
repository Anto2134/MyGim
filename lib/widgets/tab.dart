// ignore_for_file: camel_case_types
import 'package:flutter/foundation.dart';

class tab {
  Map<String, List<String>> ese2serie = {};
  String titolo = '';

  tab(String titolo) {
    this.titolo = titolo;
  }

  void setTitolo(String titolo) {
    this.titolo = titolo;
  }

  String getTitolo() {
    return this.titolo;
  }

  Map<String, List<String>> getMap() {
    return this.ese2serie;
  }

  void setMap(Map<String, List<String>> map) {
    this.ese2serie = map;
  }

  void setData(String esercizio, String serie) {
    ese2serie[esercizio] = [];
    ese2serie[esercizio]!.add(serie);
    print('alal' + ese2serie.toString());
  }
}
